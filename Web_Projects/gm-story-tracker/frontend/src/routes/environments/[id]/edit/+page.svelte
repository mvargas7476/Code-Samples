<script lang="ts">
    import EnvironmentForm from '$lib/components/EnvironmentForm.svelte';
    import { goto } from '$app/navigation';
    import type { PageData } from './$types';

    let { data }: { data: PageData } = $props();
    const id = $derived(data.environment.id);

    let errors = $state<Record<string, string[]>>({});
    let submitError = $state('');

    // Function that gets called when the child passes back the data
    async function save(payload: unknown) {
        errors = {};
        submitError = '';
        let res: Response;
        try {
            res = await fetch(`/api/environments/${id}/`, {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });
        } catch {
            submitError = 'Could not reach the server. Is the backend running?';
            return;
        }

        if (res.ok) {
            goto('/environments');
        } else if (res.status === 400) {
            errors = await res.json();
        } else {
            submitError = `Something went wrong (server responded ${res.status}).`;
        }
    }

    // Handle deleting the environment
    async function deleteEnvironment() {
        if (!confirm("Delete this environment? It will be removed from any acts it's linked to."))
            return;
        const res = await fetch(`/api/environments/${id}/`, { method: 'DELETE' });
        if (res.ok) {
            goto('/environments');
        } else {
            submitError = 'Could not delete the current environment due to an error.';
        }
    }
</script>

{#if submitError}<span class="error">{submitError}</span>{/if}
<!-- Using the ID to force remount accross multiple Environments -->
{#key data.environment.id}
    <EnvironmentForm
        initial={data.environment}
        allEnvironments={data.allEnvironments}
        {errors}
        onSave={save}
        submitLabel="Save Changes"
    />
{/key}
<button type="button" class="btn-danger" onclick={() => deleteEnvironment()}>
    Delete Environment
</button>
