// Badge filtering for the Content Library list pages. Every badge is a toggle; the page holds the
// set of active keys and hands rows through `filterByBadges` before they reach <DataTable>.

/** `"kind:npc"`, `"faction:Redbrands"`. The facet name never contains a colon; the value may. */
export function badgeKey(facet: string, value: string): string {
    return `${facet}:${value}`;
}

/**
 * Keep the rows matching EVERY active facet, matching ANY selected value within a facet.
 *
 * The within-facet OR is the point: "NPC + Adversary" has to widen the list. Plain AND across
 * everything would make that pair — the obvious thing to click — return nothing.
 */
export function filterByBadges<T>(
    rows: T[],
    active: Iterable<string>,
    keysOf: (row: T) => string[]
): T[] {
    const wanted = new Map<string, string[]>();
    for (const key of active) {
        const sep = key.indexOf(':');
        const facet = sep === -1 ? key : key.slice(0, sep);
        const bucket = wanted.get(facet);
        if (bucket) bucket.push(key);
        else wanted.set(facet, [key]);
    }
    if (wanted.size === 0) return rows;

    return rows.filter((row) => {
        const keys = new Set(keysOf(row));
        return [...wanted.values()].every((bucket) => bucket.some((k) => keys.has(k)));
    });
}
