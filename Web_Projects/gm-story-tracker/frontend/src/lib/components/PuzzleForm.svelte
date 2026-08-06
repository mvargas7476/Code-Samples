<script lang="ts">
    import { untrack } from 'svelte';
    import { flattenErrors } from '$lib/errors';
    import type { Puzzle } from '$lib/types';

    // Props: initial (edit) or undefined (create), field errors from the parent, submit handler, label
    let {
        initial,
        errors,
        onSave,
        submitLabel = 'Save'
    }: {
        initial?: Puzzle;
        errors: Record<string, string[]>;
        onSave: (payload: unknown) => void;
        submitLabel?: string;
    } = $props();

    // Simple fields — seed from initial, or defaults for create
    let form = $state(
        untrack(() => ({
            name: initial?.name ?? '',
            description: initial?.description ?? '',
            notes: initial?.notes ?? '',
            status: initial?.status ?? 'draft'
        }))
    );

    // Solutions: on edit, seed WITH each id so the serializer updates in place; on create,
    // default to the correct + alternate starter rows. Rows added later have no id => created.
    let solutions = $state<{
        id?: number;
        solution_type: string;
        description: string;
        tier: number | null;
        notes: string }[]
    >(untrack(() =>
        initial?.solutions?.length
            ? initial.solutions.map((s) => ({
                    id: s.id,
                    solution_type: s.solution_type,
                    description: s.description,
                    tier: s.tier,
                    notes: s.notes
                }))
            : [
                { solution_type: 'correct', description: '', tier: null, notes: '' },
                { solution_type: 'alternate', description: '', tier: null, notes: '' }
            ]
        )
    );

    function addSolution() {solutions.push({ solution_type: 'correct', description: '', tier: null, notes: '' });}
    function removeSolution(i: number) {solutions.splice(i, 1);}

    // Server errors for fields other than `name`/`solutions` (both surfaced separately below).
    const otherErrors = $derived(flattenErrors(errors, ['name', 'solutions']));

    // DRF returns `solutions` errors either as a single non-field string (the >=2 rule) OR as a
    // per-row array aligned to each solution
    function solutionErrors(i: number): string[] {
        const s = errors.solutions as unknown;
        if (!Array.isArray(s)) return [];
        const row = s[i];
        if (!row || typeof row !== 'object') return [];
        return flattenErrors(row as Record<string, unknown>);
    }

    function handleSubmit(event: SubmitEvent) {
        event.preventDefault();
        const payload = {
            ...form,
            solutions: solutions
                .filter((s) => s.description.trim())
                .map((s) => ({
                    // Only include id when it exists so the serializer matches (update) vs creates
                    ...(s.id != null ? { id: s.id } : {}),
                    solution_type: s.solution_type,
                    description: s.description,
                    tier: s.tier,
                    notes: s.notes
                }))
        };
        onSave(payload); // Hand the assembled payload back to the parent for POST/PATCH
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
    {#if errors.name}<span>{errors.name[0]}</span>{/if}

    <textarea bind:value={form.description} placeholder="Description"></textarea>
    <textarea bind:value={form.notes} placeholder="Notes"></textarea>
    <select bind:value={form.status}>
        <option value="draft">Draft</option>
        <option value="ready">Ready</option>
    </select>

    <h3>Solutions</h3>
    {#if errors.solutions && typeof errors.solutions[0] === 'string'}
        <span class="error">{errors.solutions[0]}</span>
    {/if}
    {#each solutions as sol, i}
        <select bind:value={sol.solution_type}>
            <option value="correct">Correct</option>
            <option value="alternate">Alternate</option>
            <option value="red_herring">Red Herring</option>
        </select>
        <textarea bind:value={sol.description} placeholder="Describe the solution"></textarea>
        <input type="number" min="1" bind:value={sol.tier} placeholder="Tier (Optional)" />
        <input bind:value={sol.notes} placeholder="GM Guidance (Optional)" />

        <button type="button" onclick={() => removeSolution(i)}>x</button>

        {#if solutionErrors(i).length}
            <ul class="error">
                {#each solutionErrors(i) as msg}
                    <li>{msg}</li>
                {/each}
            </ul>
        {/if}
    {/each}
    <button type="button" onclick={addSolution}>+ Add Solution</button>

    <button type="submit">{submitLabel}</button>
</form>
