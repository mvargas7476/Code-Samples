<script lang="ts">
    import { badgeKey } from '$lib/filters';
    import type { ActorKind } from '$lib/types';
    import type { SvelteSet } from 'svelte/reactivity';

    // A badge that toggles a list filter. Deliberately the same pixels as a static
    // <span class="badge"> — the only visible difference is the pressed state, so turning a
    // filter on doesn't make the row look like a different kind of row.
    let {
        facet, // which group this filter belongs to ('kind', 'tier', 'faction', …)
        value, // the value being filtered on
        label, // badge text, when it should read differently from the raw value
        srLabel, // visually-hidden prefix, for badges whose text doesn't say what facet it is
        kind, // ActorKind → the coloured rail; omit for a neutral badge
        warn = false, // flags a broken domain rule (red)
        active // the page's set of active filter keys — this badge toggles its own key in it
    }: {
        facet: string;
        value: string;
        label?: string;
        srLabel?: string;
        kind?: ActorKind;
        warn?: boolean;
        active: SvelteSet<string>;
    } = $props();

    const key = $derived(badgeKey(facet, value));
</script>

<!-- The hidden label sits BESIDE the badge, never inside, so it stays out of the button's name. -->
{#if srLabel}<span class="visually-hidden">{srLabel}</span>{/if}
<button
    type="button"
    class="badge"
    data-kind={kind}
    data-warn={warn}
    aria-pressed={active.has(key)}
    onclick={() => (active.has(key) ? active.delete(key) : active.add(key))}
>{label ?? value}</button>
