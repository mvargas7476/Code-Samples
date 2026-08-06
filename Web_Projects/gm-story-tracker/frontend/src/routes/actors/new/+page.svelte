<script lang="ts">
    import ActorForm from '$lib/components/ActorForm.svelte';
    import { goto } from '$app/navigation';
    import type { PageData } from './$types';

    let { data }: { data: PageData } = $props();

    let errors = $state<Record<string, string[]>>({});
    let submitError = $state('');
    
    // Function that gets called when the child passes back the data
    async function create(payload: unknown) {
        errors = {}; submitError = '';
        let res: Response;
        try {
            res = await fetch('/api/actors/', {
                method: 'POST',
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
</script>
{#if submitError}<span class="error">{submitError}</span>{/if}
<ActorForm allActors={data.allActors} {errors} onSave={create} submitLabel="Create" />