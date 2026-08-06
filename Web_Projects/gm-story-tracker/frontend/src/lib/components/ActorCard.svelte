<script lang="ts">
    import { tierLabel } from '$lib/display';
    import type { Actor } from '$lib/types';
    let { actor }: { actor: Actor } = $props();
</script>

<!-- Classification first, then narrative. Single-line CharFields, so no .prose. -->
{#if actor.tier}
    <p><strong>Tier:</strong> {tierLabel(actor.tier)}</p>
{/if}
{#if actor.actor_type}
    <p><strong>Type:</strong> {actor.actor_type}</p>
{/if}
{#if actor.factions.length}
    <p><strong>Factions:</strong> {actor.factions.join(', ')}</p>
{/if}

{#if actor.motivation}
    <p class="prose"><strong>Motivation:</strong> {actor.motivation}</p>
{/if}
{#if actor.description}
    <p class="prose">{actor.description}</p>
{/if}
{#if actor.notes}
    <p class="prose"><strong>GM notes:</strong> {actor.notes}</p>
{/if}

{#if Object.keys(actor.stats).length}
    <h4>Stats</h4>
    <ul>
        {#each Object.entries(actor.stats) as [key, value]}
            <li>{key}: {String(value)}</li>
        {/each}
    </ul>
{/if}

{#if Object.keys(actor.abilities).length}
    <h4>Abilities</h4>
    <ul>
        {#each Object.entries(actor.abilities) as [key, value]}
            <li>{key}: {String(value)}</li>
        {/each}
    </ul>
{/if}

{#if actor.features.length}
    <h4>Features</h4>
    {#each actor.features as feature}
        <p class="prose">
            <strong>{String(feature.name ?? '')}</strong> — {String(feature.description ?? '')}
        </p>
    {/each}
{/if}

