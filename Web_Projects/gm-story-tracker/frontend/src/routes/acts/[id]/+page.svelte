<script lang="ts">
    import type { PageData } from './$types';
    import { goto, invalidateAll } from '$app/navigation';
    import { page } from '$app/state';
    import ActorCard from '$lib/components/ActorCard.svelte';
    import EnvironmentCard from '$lib/components/EnvironmentCard.svelte';
    import PuzzleCard from '$lib/components/PuzzleCard.svelte';
    import { actorLine, environmentLine } from '$lib/display';

    // Getting all of the data from the backend
    let { data }: { data: PageData } = $props();
    const act = $derived(data.act);
    const isGameMode = $derived(page.url.searchParams.get('mode') === 'game');

    let editing = $state(false);
    let linkError = $state('');
    let saving = $state(false);   // guards against overlapping link PATCHes

    // Here we keep a note of which of the following below to which list
    const unlinkedActors = $derived(
        data.allActors.filter((a) => !act.actors.some((x) => x.id === a.id))
    );
    const unlinkedEnvironments = $derived(
        data.allEnvironments.filter((a) => !act.environments.some((x) => x.id === a.id))
    );
    const unlinkedPuzzles = $derived(
        data.allPuzzles.filter((a) => !act.puzzles.some((x) => x.id === a.id))
    );

    // This is how we will PATCH things so that they are part of the act.
    // `saving` serializes things: ignore clicks while a PATCH + refresh is in flight.
    async function setLinks(field: 'actors' | 'environments' | 'puzzles', ids: number[]) {
        if (saving) return;
        saving = true;
        linkError = '';
        try {
            const res = await fetch(`/api/acts/${act.id}/`, {
                method: 'PATCH',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({ [field]: ids})
            });
            if (res.ok) {
                // This refreshes the UI by loading the data
                await invalidateAll();
            } else {
                linkError = `Failed to update ${field}`
            }
        } finally {
            saving = false;
        }
    }
</script>

<article>
    <h1>Act {act.order}: {act.title}</h1>

    <!-- Mode toggle: always visible in both modes -->
    {#if isGameMode}
        <button type="button" onclick={() => goto(page.url.pathname, {replaceState: true, keepFocus: true, noScroll: true})}>
            Exit Game Mode
        </button>
    {:else}
        <button type="button" onclick={() => goto('?mode=game', {replaceState: true, keepFocus: true, noScroll: true})}>
            Game Mode
        </button>
    {/if}

    {#if isGameMode}
        <!-- GAME MODE: read-only, two-column "at the table" layout -->
        <div class="act-grid">
            {@render narrative()}

            <div class="act-content">
                <section>
                    <h2>Actors ({act.actors.length})</h2>
                    {#each act.actors as actor (actor.id)}
                        <details open class="card" data-kind={actor.kind}>
                            <summary>{actorLine(actor)}</summary>
                            <ActorCard {actor} />
                        </details>
                    {:else}
                        <p class="muted">No actors linked.</p>
                    {/each}
                </section>

                <section>
                    <h2>Environments ({act.environments.length})</h2>
                    {#each act.environments as environment (environment.id)}
                        <details open class="card">
                            <summary>{environmentLine(environment)}</summary>
                            <EnvironmentCard {environment} />
                        </details>
                    {:else}
                        <p class="muted">No environments linked.</p>
                    {/each}
                </section>

                <section>
                    <h2>Puzzles ({act.puzzles.length})</h2>
                    {#each act.puzzles as puzzle (puzzle.id)}
                        <details open class="card">
                            <summary>{puzzle.name}</summary>
                            <PuzzleCard {puzzle} />
                        </details>
                    {:else}
                        <p class="muted">No puzzles linked.</p>
                    {/each}
                </section>
            </div>
        </div>
    {:else}
        <!-- PREP MODE: same two-column layout, editable -->
        <button type="button" onclick={() => goto(`/acts/${act.id}/edit`)}>Edit act</button>

        <button type="button" onclick={() => (editing = !editing)}>
            {editing ? 'Done' : 'Edit Components'}
        </button>
        {#if linkError}<p style="color:red">{linkError}</p>{/if}

        <div class="act-grid">
            {@render narrative()}

            <div class="act-content">
                <!-- Actor Section -->
                <section>
                    <h2>Actors ({act.actors.length})</h2>
                    {#each act.actors as actor (actor.id)}
                        <details class="card">
                            <summary>{actorLine(actor)}</summary>
                            {#if editing}
                                <button type="button" disabled={saving}
                                    onclick={() => setLinks('actors', act.actors.map((a) => a.id).filter((id) => id !== actor.id))}>
                                    Remove
                                </button>
                            {/if}

                            <ActorCard {actor} />
                        </details>
                    {:else}
                        <p class="muted">No actors linked.</p>
                    {/each}
                    {#if editing}
                        <select disabled={saving} onchange={(e) => {
                            const id = Number(e.currentTarget.value);
                            if (id) setLinks('actors', [...act.actors.map((a) => a.id), id]);
                            e.currentTarget.value = '';
                        }}>
                            <option value="" disabled selected> + Link an actor</option>
                            {#each unlinkedActors as a (a.id)}
                                <option value={a.id}>{actorLine(a)}</option>
                            {/each}
                        </select>
                    {/if}
                </section>

                <!-- Environments Section -->
                <section>
                    <h2>Environments ({act.environments.length})</h2>
                    {#each act.environments as environment (environment.id)}
                        <details class="card">
                            <summary>{environmentLine(environment)}</summary>
                            {#if editing}
                                <button type="button" disabled={saving}
                                    onclick={() => setLinks('environments', act.environments.map((env) => env.id).filter((id) => id !== environment.id))}>
                                    Remove
                                </button>
                            {/if}

                            <EnvironmentCard {environment}/>
                        </details>
                    {:else}
                        <p class="muted">No environments linked.</p>
                    {/each}
                    {#if editing}
                        <select disabled={saving} onchange={(e) => {
                            const id = Number(e.currentTarget.value);
                            if (id) setLinks('environments', [...act.environments.map((env) => env.id), id]);
                            e.currentTarget.value = '';
                        }}>
                            <option value="" disabled selected> + Link an environment</option>
                            {#each unlinkedEnvironments as env (env.id)}
                                <option value={env.id}>{environmentLine(env)}</option>
                            {/each}
                        </select>
                    {/if}
                </section>

                <!-- Puzzles Section -->
                <section>
                    <h2>Puzzles ({act.puzzles.length})</h2>
                    {#each act.puzzles as puzzle (puzzle.id)}
                        <details class="card">
                            <summary>{puzzle.name}</summary>
                            {#if editing}
                                <button type="button" disabled={saving}
                                    onclick={() => setLinks('puzzles', act.puzzles.map((p) => p.id).filter((id) => id !== puzzle.id))}>
                                    Remove
                                </button>
                            {/if}

                            <PuzzleCard {puzzle} />
                        </details>
                    {:else}
                        <p class="muted">No puzzles linked.</p>
                    {/each}
                    {#if editing}
                        <select disabled={saving} onchange={(e) => {
                            const id = Number(e.currentTarget.value);
                            if (id) setLinks('puzzles', [...act.puzzles.map((p) => p.id), id]);
                            e.currentTarget.value = '';
                        }}>
                            <option value="" disabled selected> + Link a puzzle</option>
                            {#each unlinkedPuzzles as p (p.id)}
                                <option value={p.id}>{p.name} - {p.status}</option>
                            {/each}
                        </select>
                    {/if}
                </section>
            </div>
        </div>
    {/if}
</article>

<!-- Narrative column: identical in both modes, so defined once and rendered in each branch -->
{#snippet narrative()}
    <div class="act-narrative">
        {#if act.plot_hooks}
            <section class="key">
                <h2>Plot Hooks</h2>
                <p class="prose">{act.plot_hooks}</p>
            </section>
        {/if}

        {#if act.story_beats}
            <section class="key">
                <h2>Story Beats</h2>
                <p class="prose">{act.story_beats}</p>
            </section>
        {/if}

        {#if act.summary}
            <section>
                <h2>Summary</h2>
                <p class="prose">{act.summary}</p>
            </section>
        {/if}

        {#if act.climax}
            <section>
                <h2>Climax</h2>
                <p class="prose">{act.climax}</p>
            </section>
        {/if}

        {#if act.gm_notes}
            <section>
                <h2>GM Notes</h2>
                <p class="prose">{act.gm_notes}</p>
            </section>
        {/if}
    </div>
{/snippet}

<style>
    summary {
        cursor: pointer;
        font-weight: 600;
    }
    details {
        margin: 0.35rem 0;
    }

    /* ---- Act Detail: two-column layout (shared by Prep + Game modes) ---- */
    .act-grid {
        /* break out past the 900px body cap, centered, capped at 1280px */
        width: min(96vw, 1280px);
        margin-inline: calc(50% - min(96vw, 1280px) / 2);

        display: grid;
        grid-template-columns: minmax(0, 1fr) minmax(0, 1.4fr); /* narrative | wider content */
        gap: var(--space-4);
        align-items: start;
    }

    /* narrative stays in view while scanning a long content column */
    .act-narrative {
        position: sticky;
        top: var(--space-3);
        align-self: start;
        font-size: 1.05rem;
    }

    /* glance-first narrative (plot hooks + story beats) gets an accent rail */
    .act-narrative .key {
        border-left: 3px solid var(--color-accent);
        padding-left: var(--space-3);
    }

    /* larger, more scannable card headers */
    .act-content summary {
        font-size: 1.1rem;
    }

    /* Game mode: tint each actor card by kind so the table reads them at a glance. */
    .act-content details[data-kind='adversary'] {
        background: color-mix(in srgb, var(--color-surface) 80%, var(--kind-adversary) 20%);
        border-left: 4px solid var(--kind-adversary);
    }
    .act-content details[data-kind='npc'] {
        background: color-mix(in srgb, var(--color-surface) 80%, var(--kind-npc) 20%);
        border-left: 4px solid var(--kind-npc);
    }
    .act-content details[data-kind='pc'] {
        background: color-mix(in srgb, var(--color-surface) 80%, var(--kind-pc) 20%);
        border-left: 4px solid var(--kind-pc);
    }

    /* collapse to a single column on narrow screens */
    @media (max-width: 720px) {
        .act-grid {
            grid-template-columns: 1fr;
            width: auto;
            margin-inline: 0;
        }
        .act-narrative {
            position: static;
        }
    }
</style>
