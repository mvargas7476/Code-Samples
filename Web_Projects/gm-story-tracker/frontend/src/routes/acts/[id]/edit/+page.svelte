<script lang="ts">
    import { goto } from '$app/navigation';
    import { untrack } from 'svelte';
    import type { PageData } from './$types';

    let { data }: { data: PageData } = $props();
    const id = $derived(data.act.id);

    // Snapshot the loaded act into an editable draft.
    function seedForm() {
        return {
            order: data.act.order,
            title: data.act.title,
            summary: data.act.summary,
            plot_hooks: data.act.plot_hooks,
            story_beats: data.act.story_beats,
            climax: data.act.climax,
            gm_notes: data.act.gm_notes
        };
    }

    let form = $state(untrack(seedForm));

    // Reseeding Act when the ID Changes
    $effect(() => {
        data.act.id; // the only tracked dependency — re-runs on navigation to another act
        untrack(() => {
            form = seedForm();
        });
    });

    let errors = $state<Record<string, string[]>>({});
    let submitError = $state('');

    // Handle submission
    async function handleSubmit(event: SubmitEvent) {
        event.preventDefault();
        errors = {};
        submitError = '';

        let res: Response;
        try {
            res = await fetch(`/api/acts/${id}/`, {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(form)
            });
        } catch {
            submitError = 'Could not reach the server. Is the backend running?';
            return;
        }

        if (res.ok) {
            goto(`/acts/${id}`);
        } else if (res.status === 400) {
            errors = await res.json();
        } else {
            submitError = `Something went wrong (server responded ${res.status}).`;
        }
    }

    // Handle deleting the act
    async function deleteAct() {
        if (!confirm('Delete this act?')) return;
        const res = await fetch(`/api/acts/${id}/`, { method: 'DELETE' });
        if (res.ok) {
            goto(`/adventures/${data.act.adventure}`);
        } else {
            submitError = 'Could not delete the current act due to an error.';
        }
    }
</script>

<!-- ↓ the markup calls it -->
<form onsubmit={handleSubmit}>
    <input type="number" bind:value={form.order} placeholder="Order" />
    {#if errors.order}<span class="error">{errors.order[0]}</span>{/if}
    <input bind:value={form.title} placeholder="Title" />
    {#if errors.title}<span class="error">{errors.title[0]}</span>{/if}

    <textarea bind:value={form.summary} placeholder="Summary"></textarea>
    <textarea bind:value={form.plot_hooks} placeholder="Plot hooks"></textarea>
    <textarea bind:value={form.story_beats} placeholder="Story Beats"></textarea>
    <textarea bind:value={form.climax} placeholder="Climax"></textarea>
    <textarea bind:value={form.gm_notes} placeholder="GM Notes"></textarea>

    {#if submitError}<span class="error">{submitError}</span>{/if}
    <button type="submit">Save Changes</button>
</form>
<button type="button" class="btn-danger" onclick={() => deleteAct()}> Delete Act </button>
