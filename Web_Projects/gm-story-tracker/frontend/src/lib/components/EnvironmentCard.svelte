<script lang="ts">
    import { tierLabel } from '$lib/display';
    import type { Environment } from '$lib/types';
    let { environment }: { environment: Environment } = $props();
</script>

<!-- Classification first, then the narrative. Single-line CharFields, so no .prose. -->
{#if environment.tier}
    <p><strong>Tier:</strong> {tierLabel(environment.tier)}</p>
{/if}
{#if environment.environment_type}
    <p><strong>Type:</strong> {environment.environment_type}</p>
{/if}

{#if environment.description}
    <p class="prose"><strong>Description:</strong> {environment.description}</p>
{/if}
{#if environment.sensory_details}
    <p class="prose">{environment.sensory_details}</p>
{/if}
{#if environment.hazards}
    <p class="prose"><strong>Hazards:</strong> {environment.hazards}</p>
{/if}
{#if environment.secrets}
    <p class="prose"><strong>Secrets:</strong> {environment.secrets}</p>
{/if}
{#if environment.notes}
    <p class="prose"><strong>Notes:</strong> {environment.notes}</p>
{/if}

