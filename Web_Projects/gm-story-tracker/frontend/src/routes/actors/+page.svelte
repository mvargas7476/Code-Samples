<script lang="ts">
    import type { PageData } from './$types';
    import { SvelteSet } from 'svelte/reactivity';
    import DataTable from '$lib/components/DataTable.svelte';
    import ActorCard from '$lib/components/ActorCard.svelte';
    import FilterBadge from '$lib/components/FilterBadge.svelte';
    import { KIND_LABEL, tierLabel } from '$lib/display';
    import { badgeKey, filterByBadges } from '$lib/filters';
    import type { Actor } from '$lib/types';

    let { data }: { data: PageData } = $props();

    // kind/tier/type/factions are clickable badges for sorting
    const columns = [
        { key: 'name', label: 'Actor', get: (a: Actor) => a.name },
        { key: 'actions', label: 'Actions', srOnly: true }
    ];

    // Every badge this row renders, as a filter key. Must stay in sync with the markup below.
    function keysOf(a: Actor): string[] {
        return [
            badgeKey('kind', a.kind),
            ...(a.tier ? [badgeKey('tier', a.tier)] : []),
            ...(a.actor_type ? [badgeKey('type', a.actor_type)] : []),
            ...a.factions.map((f) => badgeKey('faction', f))
        ];
    }

    const active = new SvelteSet<string>();
    const rows = $derived(filterByBadges(data.actors, active, keysOf));
</script>

<div class="list-header">
    <h1>
        Actors
        <span class="count">
            {#if active.size}{rows.length} of {data.actors.length}{:else}{data.actors.length}{/if}
        </span>
    </h1>
    <a class="btn" href="/actors/new">+ New Actor</a>
</div>

{#if active.size}
    <p class="filter-bar">
        <span class="muted">Filtered by {active.size} badge{active.size === 1 ? '' : 's'}.</span>
        <button type="button" class="btn btn-sm" onclick={() => active.clear()}>Clear filters</button>
    </p>
{/if}

{#if data.actors.length === 0}
    <p class="empty muted">
        No actors yet. <a href="/actors/new">Create your first actor</a> to start your content
        library.
    </p>
{:else if rows.length === 0}
    <p class="empty muted">No actors match the active filters.</p>
{:else}
    <DataTable {columns} {rows}>
        {#snippet row(actor)}
            <th scope="row">
                {actor.name}
                <div class="badges">
                    <FilterBadge
                        facet="kind"
                        value={actor.kind}
                        label={KIND_LABEL[actor.kind]}
                        srLabel="Kind: "
                        kind={actor.kind}
                        {active}
                    />
                    {#if actor.tier}
                        <FilterBadge
                            facet="tier"
                            value={actor.tier}
                            label={tierLabel(actor.tier)}
                            {active}
                        />
                    {/if}
                    {#if actor.actor_type}
                        <FilterBadge
                            facet="type"
                            value={actor.actor_type}
                            srLabel="Type: "
                            {active}
                        />
                    {/if}
                    {#if actor.factions.length}
                        <!-- label the group once, not once per badge -->
                        <span class="visually-hidden">Factions: </span>
                        <!-- keyed by index: duplicate faction names are possible -->
                        {#each actor.factions as faction, i (i)}
                            <FilterBadge facet="faction" value={faction} {active} />
                        {/each}
                    {/if}
                </div>
            </th>
            <td>
                <a class="btn btn-sm" href={`/actors/${actor.id}/edit`}>Edit</a>
            </td>
        {/snippet}
        {#snippet detail(actor)}
            <ActorCard {actor} />
        {/snippet}
    </DataTable>
{/if}
