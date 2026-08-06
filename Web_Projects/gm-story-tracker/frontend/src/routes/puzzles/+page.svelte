<script lang="ts">
    import type { PageData } from './$types';
    import { SvelteSet } from 'svelte/reactivity';
    import DataTable from '$lib/components/DataTable.svelte';
    import PuzzleCard from '$lib/components/PuzzleCard.svelte';
    import FilterBadge from '$lib/components/FilterBadge.svelte';
    import { PUZZLE_STATUS_LABEL } from '$lib/display';
    import { badgeKey, filterByBadges } from '$lib/filters';
    import type { Puzzle } from '$lib/types';

    let { data }: { data: PageData } = $props();

    const columns = [
        { key: 'name', label: 'Puzzle', get: (p: Puzzle) => p.name },
        { key: 'actions', label: 'Actions', srOnly: true }
    ];

    // The >=2 rule is serializer-only, so a saved puzzle can still break it. Filtering on the exact
    // solution count would be useless; filtering on "which ones are short" is the reason to look.
    const needsSolutions = (p: Puzzle) => p.solutions.length < 2;

    function keysOf(p: Puzzle): string[] {
        return [
            badgeKey('status', p.status),
            ...(needsSolutions(p) ? [badgeKey('solutions', 'incomplete')] : [])
        ];
    }

    const active = new SvelteSet<string>();
    const rows = $derived(filterByBadges(data.puzzles, active, keysOf));
</script>

<div class="list-header">
    <h1>
        Puzzles
        <span class="count">
            {#if active.size}{rows.length} of {data.puzzles.length}{:else}{data.puzzles.length}{/if}
        </span>
    </h1>
    <a class="btn" href="/puzzles/new">+ New Puzzle</a>
</div>

{#if active.size}
    <p class="filter-bar">
        <span class="muted">Filtered by {active.size} badge{active.size === 1 ? '' : 's'}.</span>
        <button type="button" class="btn btn-sm" onclick={() => active.clear()}>Clear filters</button>
    </p>
{/if}

{#if data.puzzles.length === 0}
    <p class="empty muted">
        No puzzles yet. <a href="/puzzles/new">Create your first puzzle</a> to start your content
        library.
    </p>
{:else if rows.length === 0}
    <p class="empty muted">No puzzles match the active filters.</p>
{:else}
    <DataTable {columns} {rows}>
        {#snippet row(puzzle)}
            <th scope="row">
                {puzzle.name}
                <div class="badges">
                    <FilterBadge
                        facet="status"
                        value={puzzle.status}
                        label={PUZZLE_STATUS_LABEL[puzzle.status]}
                        srLabel="Status: "
                        {active}
                    />
                    {#if needsSolutions(puzzle)}
                        <!-- Flag the broken rule rather than hiding it — and say so in the text,
                             so the warning survives for anyone who can't see the red. -->
                        <FilterBadge
                            facet="solutions"
                            value="incomplete"
                            label="{puzzle.solutions.length} {puzzle.solutions.length === 1
                                ? 'solution'
                                : 'solutions'}"
                            srLabel="Needs at least 2 solutions: "
                            warn
                            {active}
                        />
                    {:else}
                        <span class="badge">{puzzle.solutions.length} solutions</span>
                    {/if}
                </div>
            </th>
            <td>
                <a class="btn btn-sm" href={`/puzzles/${puzzle.id}/edit`}>Edit</a>
            </td>
        {/snippet}
        {#snippet detail(puzzle)}
            <PuzzleCard {puzzle} />
        {/snippet}
    </DataTable>
{/if}
