<script lang="ts">
    import type { PageData } from './$types';
    import { SvelteSet } from 'svelte/reactivity';
    import DataTable from '$lib/components/DataTable.svelte';
    import EnvironmentCard from '$lib/components/EnvironmentCard.svelte';
    import FilterBadge from '$lib/components/FilterBadge.svelte';
    import { tierLabel } from '$lib/display';
    import { badgeKey, filterByBadges } from '$lib/filters';
    import type { Environment } from '$lib/types';

    let { data }: { data: PageData } = $props();

    const columns = [
        { key: 'name', label: 'Environment', get: (e: Environment) => e.name },
        { key: 'actions', label: 'Actions', srOnly: true }
    ];

    // Every badge this row renders, as a filter key. Must stay in sync with the markup below.
    function keysOf(e: Environment): string[] {
        return [
            ...(e.tier ? [badgeKey('tier', e.tier)] : []),
            ...(e.environment_type ? [badgeKey('type', e.environment_type)] : [])
        ];
    }

    const active = new SvelteSet<string>();
    const rows = $derived(filterByBadges(data.environments, active, keysOf));
</script>

<div class="list-header">
    <h1>
        Environments
        <span class="count">
            {#if active.size}{rows.length} of {data.environments.length}{:else}{data.environments
                    .length}{/if}
        </span>
    </h1>
    <a class="btn" href="/environments/new">+ New Environment</a>
</div>

{#if active.size}
    <p class="filter-bar">
        <span class="muted">Filtered by {active.size} badge{active.size === 1 ? '' : 's'}.</span>
        <button type="button" class="btn btn-sm" onclick={() => active.clear()}>Clear filters</button>
    </p>
{/if}

{#if data.environments.length === 0}
    <p class="empty muted">
        No environments yet. <a href="/environments/new">Create your first environment</a> to start
        your content library.
    </p>
{:else if rows.length === 0}
    <p class="empty muted">No environments match the active filters.</p>
{:else}
    <DataTable {columns} {rows}>
        {#snippet row(environment)}
            <th scope="row">
                {environment.name}
                <!-- Omit the row when neither is set, so an unclassified environment stays one line. -->
                {#if environment.tier || environment.environment_type}
                    <div class="badges">
                        {#if environment.tier}
                            <FilterBadge
                                facet="tier"
                                value={environment.tier}
                                label={tierLabel(environment.tier)}
                                {active}
                            />
                        {/if}
                        {#if environment.environment_type}
                            <FilterBadge
                                facet="type"
                                value={environment.environment_type}
                                srLabel="Type: "
                                {active}
                            />
                        {/if}
                    </div>
                {/if}
            </th>
            <td>
                <a class="btn btn-sm" href={`/environments/${environment.id}/edit`}>Edit</a>
            </td>
        {/snippet}
        {#snippet detail(environment)}
            <EnvironmentCard {environment} />
        {/snippet}
    </DataTable>
{/if}
