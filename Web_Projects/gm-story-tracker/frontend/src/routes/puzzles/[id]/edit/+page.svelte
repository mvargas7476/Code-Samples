<script lang="ts">
    import PuzzleForm from '$lib/components/PuzzleForm.svelte';
    import { goto } from '$app/navigation';
    import type { PageData } from './$types';

    let { data }: { data: PageData } = $props();

    let errors = $state<Record<string, string[]>>({});
    let submitError = $state('');

    // Called when the child hands back the assembled payload
    async function save(payload: unknown) {
        errors = {};
        submitError = '';
        let res: Response;
        try {
            res = await fetch(`/api/puzzles/${data.puzzle.id}/`, {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });
        } catch {
            submitError = 'Could not reach the server. Is the backend running?';
            return;
        }

        if (res.ok) {
            goto('/puzzles');
        } else if (res.status === 400) {
            errors = await res.json();
        } else {
            submitError = `Something went wrong (server responded ${res.status}).`;
        }
    }

    // Handle deleting the puzzle
    async function deletePuzzle() {
        if (!confirm('Delete this puzzle?')) return;
        const res = await fetch(`/api/puzzles/${data.puzzle.id}/`, { method: 'DELETE' });
        if (res.ok) {
            goto('/puzzles');
        } else {
            submitError = 'Could not delete the current puzzle due to an error.';
        }
    }
</script>

{#if submitError}<span class="error">{submitError}</span>{/if}
<!-- Using the ID to force remount accross multiple Puzzles -->
{#key data.puzzle.id}
    <PuzzleForm initial={data.puzzle} {errors} onSave={save} submitLabel="Save Changes" />
{/key}
<button type="button" class="btn-danger" onclick={deletePuzzle}>Delete Puzzle</button>
