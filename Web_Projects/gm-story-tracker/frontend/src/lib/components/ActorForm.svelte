<script lang="ts">
    import { untrack } from 'svelte';
    import { uniqueSorted } from '$lib/suggestions';
    import { flattenErrors } from '$lib/errors';
    import { KIND_LABEL } from '$lib/display';
    import type { Actor } from '$lib/types';

    // This created the original Props to use. Whether it is empty or reading them
    let {
        initial, // API-shape Actor for edit; undefined for create
        allActors = [], // every actor, only to build the <datalist> suggestions
        errors, // Record<string, string[]> — field errors from the parent
        onSave, // (payload) => void — the parent's fetch handler
        submitLabel = 'Save'
    }: {
        initial?: Actor;
        allActors?: Actor[];
        errors: Record<string, string[]>;
        onSave: (payload: unknown) => void;
        submitLabel?: string;
    } = $props();

    // Seed the form once from `initial` (or defaults for create)
    let form = $state(untrack(() => ({
        name: initial?.name ?? '',
        kind: initial?.kind ?? 'npc',
        tier: initial?.tier ?? '',
        actor_type: initial?.actor_type ?? '',
        motivation: initial?.motivation ?? '',
        description: initial?.description ?? '',
        notes: initial?.notes ?? ''
    })));

    // Reading the stats from the database into the desired object
    let stats = $state(untrack(() =>
        Object.entries(initial?.stats ?? {}).map(([key, value]) => ({ key, value: String(value) }))
    ));

    let abilities = $state(untrack(() =>
        Object.entries(initial?.abilities ?? {}).map(([key, value]) => ({ key, value: String(value) }))
    ));

    // Reading the abilities the same way we do the stats. Spread each feature first so any keys
    // beyond name/description survive an edit round-trip instead of being dropped.
    let features = $state(untrack(() =>
        (initial?.features ?? []).map((f) => ({
            ...f,
            name: String(f.name ?? ''),
            description: String(f.description ?? '')
        }))
    ));

    // A plain list of strings, unlike features. Spread-copy so the rows are a local draft.
    let factions = $state<string[]>(untrack(() => [...(initial?.factions ?? [])]));

    // Adding and removing different sections to the Actor
    function addStat() {stats.push({ key: '', value: '' });}
    function removeStat(id: number) {stats.splice(id, 1);}
    function addAbility() {abilities.push({ key: '', value: '' });}
    function removeAbility(id: number) {abilities.splice(id, 1);
    }
    function addFeature() {
        features.push({ name: '', description: '' });
    }
    function removeFeature(id: number) {
        features.splice(id, 1);
    }
    function addFaction() {
        factions.push('');
    }
    function removeFaction(id: number) {
        factions.splice(id, 1);
    }

    // Coerce stat/ability text back into JSON scalars so values round-trip losslessly:
    // "20" -> 20, "true"/"false" -> boolean, "null" -> null. Anything else (non-numeric,
    // leading zeros, exponents) is kept verbatim as a string.
    function coerceValue(val: string): string | number | boolean | null {
        const txt = val.trim();
        if (txt === '') {
            return val;
        }
        if (txt === 'true') return true;
        if (txt === 'false') return false;
        if (txt === 'null') return null;
        const num = Number(txt);
        return Number.isFinite(num) && String(num) === txt ? num : val;
    }

    // Suggestions from values already in use.
    const tierOptions = $derived(uniqueSorted(allActors.map((a) => a.tier)));
    const typeOptions = $derived(uniqueSorted(allActors.map((a) => a.actor_type)));
    const factionOptions = $derived(uniqueSorted(allActors.flatMap((a) => a.factions)));

    // Surface any server errors that AREN'T already shown inline (everything except `name`).
    const otherErrors = $derived(flattenErrors(errors, ['name']));

    function handleSubmit(event: SubmitEvent) {
        event.preventDefault();
        const payload = {
            ...form,
            factions: factions.map((f) => f.trim()).filter(Boolean),
            stats: Object.fromEntries(stats.filter((s) => s.key.trim()).map((s) => [s.key, coerceValue(s.value)])),
            abilities: Object.fromEntries(abilities.filter((a) => a.key.trim()).map((a) => [a.key, coerceValue(a.value)])),
            features: features.filter((f) => f.name.trim())
        };
        onSave(payload);   // Sending it back to the parent for submission
    }
</script>

<!-- ↓ the markup calls it -->
<form onsubmit={handleSubmit}>
    {#if otherErrors.length}
        <ul class="error">
            {#each otherErrors as msg}
                <li>{msg}</li>
            {/each}
        </ul>
    {/if}

    <input bind:value={form.name} placeholder="Name" />
    {#if errors.name}<span class="error">{errors.name[0]}</span>{/if}

    <select bind:value={form.kind}>
        {#each Object.entries(KIND_LABEL) as [value, label] (value)}
            <option {value}>{label}</option>
        {/each}
    </select>

    <input bind:value={form.tier} placeholder="Tier of play (e.g. 2)" list="actor-tier-options" />
    <input bind:value={form.actor_type} placeholder="Type (e.g. Bruiser)" list="actor-type-options" />

    <textarea bind:value={form.description} placeholder="Description"></textarea>
    <textarea bind:value={form.motivation} placeholder="Motivations"></textarea>
    <textarea bind:value={form.notes} placeholder="Notes"></textarea>

    <h3>Factions</h3>
    {#each factions, i}
        <div class="kv-row">
            <input
                bind:value={factions[i]}
                placeholder="e.g. Redbrands"
                list="actor-faction-options"
            />
            <button type="button" onclick={() => removeFaction(i)}>✕</button>
        </div>
    {/each}
    <button type="button" onclick={addFaction}>+ Add faction</button>

    <h3>Stats</h3>
    {#each stats as stat, i}
        <div class="kv-row">
            <input bind:value={stat.key} placeholder="e.g. Hit Points" />
            <input bind:value={stat.value} placeholder="e.g. 20" />
            <button type="button" onclick={() => removeStat(i)}>✕</button>
        </div>
    {/each}
    <button type="button" onclick={addStat}>+ Add stat</button>

    <h3>Abilities</h3>
    {#each abilities as ability, i}
        <div class="kv-row">
            <input bind:value={ability.key} placeholder="e.g. Strength" />
            <input bind:value={ability.value} placeholder="e.g. 18" />
            <button type="button" onclick={() => removeAbility(i)}>✕</button>
        </div>
    {/each}
    <button type="button" onclick={addAbility}>+ Add ability</button>

    <h3>Features</h3>
    {#each features as feature, i}
        <div class="kv-row">
            <input bind:value={feature.name} placeholder="e.g. Not Done Yet" />
            <input bind:value={feature.description} placeholder="e.g. " />
            <button type="button" onclick={() => removeFeature(i)}>✕</button>
        </div>
    {/each}
    <button type="button" onclick={addFeature}>+ Add Feature</button>

    <button type="submit">{submitLabel}</button>

    <datalist id="actor-tier-options">
        {#each tierOptions as opt (opt)}<option value={opt}></option>{/each}
    </datalist>
    <datalist id="actor-type-options">
        {#each typeOptions as opt (opt)}<option value={opt}></option>{/each}
    </datalist>
    <datalist id="actor-faction-options">
        {#each factionOptions as opt (opt)}<option value={opt}></option>{/each}
    </datalist>
</form>

<style>
    /* One JSON entry per row (key + value + remove), stacked vertically */
    .kv-row {
        display: flex;
        align-items: center;
        gap: var(--space-2);
        margin: var(--space-1) 0;
    }
    .kv-row input {
        margin: 0;
    }
</style>
