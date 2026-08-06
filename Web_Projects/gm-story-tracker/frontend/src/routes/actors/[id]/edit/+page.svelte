<script lang="ts">
    import ActorForm from '$lib/components/ActorForm.svelte';
    import { goto } from '$app/navigation';
    import type { PageData } from './$types';

    let { data }: { data: PageData } = $props();
    
    let errors = $state<Record<string, string[]>>({});
    let submitError = $state('');
    
    // Function that gets called when the child passes back the data
    async function save(payload: unknown) {
        errors = {}; submitError = '';
        let res: Response;
        try {
            res = await fetch(`/api/actors/${data.actor.id}/`, {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });
        } catch {
            submitError = 'Could not reach the server. Is the backend running?';
            return;
        }
        
        if (res.ok) {
            goto('/actors');
        } else if (res.status === 400) {
            errors = await res.json();
        } else {
            submitError = `Something went wrong (server responded ${res.status}).`;
        }
    }
    
    async function deleteActor() {
        if (!confirm('Delete this actor?')) return;
        const res = await fetch(`/api/actors/${data.actor.id}/`, { method: 'DELETE' });
        if (res.ok) {
            goto('/actors');
        } else {
            submitError = 'Could not delete the current actor due to an error.';
        }
    }
</script>
{#if submitError}<span class="error">{submitError}</span>{/if}
<!-- Using the ID to force remount accross multiple Actors -->
{#key data.actor.id}
    <ActorForm
        initial={data.actor}
        allActors={data.allActors}
        {errors}
        onSave={save}
        submitLabel="Save"
    />
{/key}
<button type="button" class="btn-danger" onclick={deleteActor}>Delete</button>