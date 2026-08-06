<script lang="ts">
    import type { Puzzle } from '$lib/types';
    let { puzzle }: { puzzle: Puzzle } = $props();
</script>

{#if puzzle.description}
    <p class="prose"><strong>Description:</strong> {puzzle.description}</p>
{/if}
{#if puzzle.notes}
    <p class="prose"><strong>Notes:</strong> {puzzle.notes}</p>
{/if}
{#if puzzle.status}
    <p class="prose">{puzzle.status}</p>
{/if}
{#if puzzle.solutions.length}
    <h4>Solutions</h4>
    <ul>
        {#each puzzle.solutions as sol (sol.id)}
            <li>
                <strong>{sol.solution_type}</strong>{#if sol.tier != null}
                    (tier {sol.tier}){/if}
                <p class="prose">{sol.description}</p>
                {#if sol.notes}<p class="prose">
                        <strong>GM:</strong>
                        {sol.notes}
                    </p>{/if}
            </li>
        {/each}
    </ul>
{/if}
