<script lang="ts">
    import PuzzleForm from '$lib/components/PuzzleForm.svelte';
    import { goto } from '$app/navigation';

    let errors = $state<Record<string, string[]>>({});
    let submitError = $state('');

    // Called when the child hands back the assembled payload
    async function create(payload: unknown) {
        errors = {};
        submitError = '';
        let res: Response;
        try {
            res = await fetch('/api/puzzles/', {
                method: 'POST',
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
</script>

{#if submitError}<span class="error">{submitError}</span>{/if}
<PuzzleForm {errors} onSave={create} submitLabel="Create" />
