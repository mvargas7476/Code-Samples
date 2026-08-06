<script lang="ts">
    import { goto } from '$app/navigation';
    import type { PageData } from './$types';
    import { untrack } from 'svelte';
    
    let { data }: { data: PageData } = $props();
    const id = $derived(data.adventure.id);

    // Snapshot the loaded adventure into an editable draft.
    function seedForm() {
        return {
            title: data.adventure.title,
            story_setting: data.adventure.story_setting,
            description: data.adventure.description,
            status: data.adventure.status
        };
    }

    let form = $state(untrack(seedForm));

    // Reseeding Adventures when the ID Changes
    $effect(() => {
        data.adventure.id; // the only tracked dependency
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
            res = await fetch(`/api/adventures/${id}/`, {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(form)
            });
        } catch {
            submitError = 'Could not reach the server. Is the backend running?';
            return;
        }

        if (res.ok) {
            goto(`/adventures/${id}`);
        } else if (res.status === 400) {
            errors = await res.json();
        } else {
            submitError = `Something went wrong (server responded ${res.status}).`;
        }
    }
    
    // Handle deleting the adventure
    async function deleteAdventure() {
        if (!confirm('Delete this adventure? This also deletes its acts.')) return;
        const res = await fetch(`/api/adventures/${id}/`, { 
            method: 'DELETE' 
        });
        if (res.ok) {
            goto('/');
        } else {
            submitError = 'Could not delete the current adventure due to an error.';
            return;
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
    <button type="submit">Save Changes</button>
</form>
<button type="button" class="btn-danger" onclick={() => deleteAdventure()}>
    Delete Adventure
</button>
