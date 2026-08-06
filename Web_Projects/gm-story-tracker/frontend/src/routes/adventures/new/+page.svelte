<script lang="ts">
    import { goto } from '$app/navigation';

    // A single object holding every field. Reactive: editing it re-renders the UI.
    let form = $state({
        title: '',
        story_setting: '',
        description: '',
        status: 'planning' // matches AdventureStatus
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
            res = await fetch('/api/adventures/', {
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
            goto(`/adventures/${created.id}`);
        } else if (res.status === 400) {
            errors = await res.json();
        } else {
            submitError = `Something went wrong (server responded ${res.status}).`;
        }
    }
</script>

<!-- ↓ the markup calls it -->
<form onsubmit={handleSubmit}>
    <input bind:value={form.title} placeholder="Title" />
    {#if errors.title}<span>{errors.title[0]}</span>{/if}

    <input bind:value={form.story_setting} placeholder="Your World" />

    <textarea bind:value={form.description} placeholder="Description"></textarea>

    <!-- Option value must match the STORED string, not the label -->
    <select bind:value={form.status}>
        <option value="planning">Planning</option>
        <option value="active">Active</option>
        <option value="completed">Completed</option>
        <option value="archived">Archived</option>
    </select>

    {#if submitError}<span class="error">{submitError}</span>{/if}
    <button type="submit">Create</button>
</form>
