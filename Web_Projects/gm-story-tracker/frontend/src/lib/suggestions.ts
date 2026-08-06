// <datalist> suggestions built from values already in use, so the freeform fields don't drift
// into "2" / "Tier 2" / "T2". Advisory only — a datalist never blocks typing something new.

/** Dedupe, drop blanks, sort case-insensitively (matching DataTable's comparator). */
export function uniqueSorted(values: string[]): string[] {
    return [...new Set(values.map((v) => v.trim()).filter(Boolean))].sort((a, b) =>
        a.localeCompare(b, undefined, { sensitivity: 'base' })
    );
}

/**
    Fetch a whole collection to feed the <datalist>s. 
 */
export async function loadSuggestions<T>(fetch: typeof globalThis.fetch, url: string): Promise<T[]> {
    try {
        const res = await fetch(url);
        return res.ok ? await res.json() : [];
    } catch {
        return [];
    }
}
