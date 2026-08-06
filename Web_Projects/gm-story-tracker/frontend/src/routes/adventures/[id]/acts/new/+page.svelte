<script lang="ts">
    import { goto } from '$app/navigation';
    import { page } from '$app/state';

    // A single object holding every field. Reactive: editing it re-renders the UI.
    let form = $state({
        adventure: page.params.id,
        order: 1,
        title: '',
        summary: '',
        plot_hooks: '',
        story_beats: '',
        climax: '',
        gm_notes: ''
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
            res = await fetch('/api/acts/', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(form)
            });
        } catch {
            submitError = 'Could not reach the server. Is the backend running?';
            return;
        }

        if (res.ok) {
            const created = await res.json();
            goto(`/acts/${created.id}`);
        } else if (res.status === 400) {
            errors = await res.json();
        } else {
            submitError = `Something went wrong (server responded ${res.status}).`;
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
    <button type="submit">Create</button>
</form>
