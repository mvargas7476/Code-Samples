<script lang="ts">
    import type { PageData } from './$types';
    import DataTable from '$lib/components/DataTable.svelte';
    import type { Adventure } from '$lib/types';

    let { data }: { data: PageData } = $props();

    const columns = [
        { key: 'title', label: 'Title', get: (a: Adventure) => a.title },
        { key: 'status', label: 'Status', get: (a: Adventure) => a.status },
        { key: 'created', label: 'Created', get: (a: Adventure) => a.created_at }
    ];
</script>

<div class="list-header">
    <h1>Adventures <span class="count">{data.adventures.length}</span></h1>
    <a class="btn" href="/adventures/new">+ New Adventure</a>
</div>

{#if data.adventures.length === 0}
    <p class="empty muted">
        No adventures yet. <a href="/adventures/new">Create your first adventure</a> to get started.
    </p>
{:else}
    <DataTable {columns} rows={data.adventures}>
        {#snippet row(adventure)}
            <td><a href="/adventures/{adventure.id}">{adventure.title}</a></td>
            <td>{adventure.status}</td>
            <td>{new Date(adventure.created_at).toLocaleDateString()}</td>
        {/snippet}
    </DataTable>
{/if}
