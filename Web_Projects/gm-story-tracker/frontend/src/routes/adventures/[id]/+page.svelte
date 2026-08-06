<script lang="ts">
    import type { PageData } from './$types';
    import DataTable from '$lib/components/DataTable.svelte';
    import type { ActSummary } from '$lib/types';

    let { data }: { data: PageData } = $props();

    const columns = [
        { key: 'order', label: '#', get: (a: ActSummary) => a.order },
        { key: 'title', label: 'Title', get: (a: ActSummary) => a.title }
    ];
</script>

<a class="btn" href={`/adventures/${data.adventure.id}/acts/new`}>+ Add Act</a>
<a class="btn" href={`/adventures/${data.adventure.id}/edit`}>Edit/Delete</a>

<article>
    <h1>{data.adventure.title} - {data.adventure.status}</h1>

    {#if data.adventure.story_setting}
        <section>
            <h2>World: {data.adventure.story_setting}</h2>
        </section>
    {/if}
    {#if data.adventure.description}
        <section>
            <h3>Description</h3>
            <p class="prose">{data.adventure.description}</p>
        </section>
    {/if}
</article>

<h2>Acts</h2>
{#if data.adventure.acts.length === 0}
    <p>No acts yet.</p>
{:else}
    <DataTable {columns} rows={data.adventure.acts}>
        {#snippet row(act)}
            <td>{act.order}</td>
            <td><a href="/acts/{act.id}">{act.title}</a></td>
        {/snippet}
        {#snippet detail(act)}
            <h4>Summary</h4>
            <p class="prose">{act.summary || 'No summary.'}</p>
        {/snippet}
    </DataTable>
{/if}
