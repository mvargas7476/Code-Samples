<script lang="ts">
    import { untrack } from 'svelte';
    import { uniqueSorted } from '$lib/suggestions';
    import { flattenErrors } from '$lib/errors';
    import type { Environment } from '$lib/types';

    // Same contract as ActorForm: `initial` for edit / undefined for create, and onSave so the
    // PARENT owns the fetch (POST vs PATCH) and the delete button.
    let {
        initial,
        allEnvironments = [], // every environment, only to build the <datalist> suggestions
        errors,
        onSave,
        submitLabel = 'Save'
    }: {
        initial?: Environment;
        allEnvironments?: Environment[];
        errors: Record<string, string[]>;
        onSave: (payload: unknown) => void;
        submitLabel?: string;
    } = $props();

    // Seed once from `initial` (or defaults for create); the parent's {#key} remounts on navigation.
    let form = $state(untrack(() => ({
        name: initial?.name ?? '',
        tier: initial?.tier ?? '',
        environment_type: initial?.environment_type ?? '',
        description: initial?.description ?? '',
        sensory_details: initial?.sensory_details ?? '',
        hazards: initial?.hazards ?? '',
        secrets: initial?.secrets ?? '',
        notes: initial?.notes ?? ''
    })));

    // Suggestions from values already in use, so the freeform fields don't drift.
    const tierOptions = $derived(uniqueSorted(allEnvironments.map((e) => e.tier)));
    const typeOptions = $derived(uniqueSorted(allEnvironments.map((e) => e.environment_type)));

    // Surface server errors not already shown inline (everything except `name`). Without this a
    // 400 on any other field renders nothing at all and the form silently does nothing.
    const otherErrors = $derived(flattenErrors(errors, ['name']));

    function handleSubmit(event: SubmitEvent) {
        event.preventDefault();
        onSave({ ...form }); // Sending it back to the parent for submission
    }
</script>

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

    <!-- Plain text, NOT type="number": tiers of play are freeform. -->
    <input bind:value={form.tier} placeholder="Tier of play (e.g. 2)" list="environment-tier-options" />
    <input
        bind:value={form.environment_type}
        placeholder="Type (e.g. Cave)"
        list="environment-type-options"
    />

    <textarea bind:value={form.description} placeholder="Description"></textarea>
    <textarea bind:value={form.sensory_details} placeholder="Sensory Details"></textarea>
    <textarea bind:value={form.hazards} placeholder="Hazards"></textarea>
    <textarea bind:value={form.secrets} placeholder="Secrets"></textarea>
    <textarea bind:value={form.notes} placeholder="Notes"></textarea>

    <button type="submit">{submitLabel}</button>

    <!-- Render nothing, so they sit out of the visual flow. -->
    <datalist id="environment-tier-options">
        {#each tierOptions as opt (opt)}<option value={opt}></option>{/each}
    </datalist>
    <datalist id="environment-type-options">
        {#each typeOptions as opt (opt)}<option value={opt}></option>{/each}
    </datalist>
</form>
