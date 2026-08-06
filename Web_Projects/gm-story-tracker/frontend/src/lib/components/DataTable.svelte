<script lang="ts" generics="T extends { id: number }">
    import type { Snippet } from 'svelte';
    import { SvelteSet } from 'svelte/reactivity';

    type Column = {
        key: string; // identity for sort state + {#each} key
        label: string;
        get?: (row: T) => string | number; // provide → column is sortable (sort accessor)
        srOnly?: boolean; // render label visually-hidden (e.g. an actions column with no visible header)
    };

    let {
        columns,
        rows,
        row,
        detail
    }: {
        columns: Column[];
        rows: T[];
        // Renders the <td>s for one row. Contract: emit exactly columns.length cells
        // (unchecked — a mismatch silently misaligns the table).
        row: Snippet<[T]>;
        // Optional: expanded detail for a row. When provided, each row gets an expander
        // toggle and this renders in a full-width row beneath it (click-to-expand).
        detail?: Snippet<[T]>;
    } = $props();

    let sortKey = $state<string | null>(null);
    let sortDir = $state<'asc' | 'desc'>('asc');
    const open = new SvelteSet<number>(); // ids of currently-expanded rows

    function toggleOpen(id: number) {
        if (open.has(id)) open.delete(id);
        else open.add(id);
    }

    // total column count for the detail row's colspan (+1 for the expander column)
    const span = $derived(columns.length + (detail ? 1 : 0));

    function toggleSort(col: Column) {
        if (!col.get) return; // not sortable
        if (sortKey === col.key) {
            sortDir = sortDir === 'asc' ? 'desc' : 'asc';
        } else {
            sortKey = col.key;
            sortDir = 'asc';
        }
    }

    const sorted = $derived.by(() => {
        const col = columns.find((c) => c.key === sortKey);
        if (!col?.get) return rows; // no active sort → server order
        const get = col.get;
        const dir = sortDir === 'asc' ? 1 : -1;
        // clone: never mutate the rows prop
        return [...rows].sort((a, b) => {
            const av = get(a);
            const bv = get(b);
            if (typeof av === 'number' && typeof bv === 'number') return (av - bv) * dir;
            return String(av).localeCompare(String(bv), undefined, { sensitivity: 'base' }) * dir;
        });
    });
</script>

<table>
    <thead>
        <tr>
            {#if detail}
                <th class="expander-col"><span class="visually-hidden">Expand</span></th>
            {/if}
            {#each columns as col (col.key)}
                <th
                    aria-sort={!col.get
                        ? undefined
                        : sortKey === col.key
                          ? sortDir === 'asc'
                              ? 'ascending'
                              : 'descending'
                          : 'none'}
                >
                    {#if col.get}
                        <button type="button" class="sort" onclick={() => toggleSort(col)}>
                            {col.label}
                            {#if sortKey === col.key}
                                <span aria-hidden="true">{sortDir === 'asc' ? '▲' : '▼'}</span>
                            {/if}
                        </button>
                    {:else if col.srOnly}
                        <span class="visually-hidden">{col.label}</span>
                    {:else}
                        {col.label}
                    {/if}
                </th>
            {/each}
        </tr>
    </thead>
    <tbody>
        {#each sorted as item (item.id)}
            <tr>
                {#if detail}
                    <td class="expander-col">
                        <button
                            type="button"
                            class="expander"
                            aria-expanded={open.has(item.id)}
                            aria-label={open.has(item.id) ? 'Collapse row' : 'Expand row'}
                            onclick={() => toggleOpen(item.id)}
                        >
                            <span aria-hidden="true">{open.has(item.id) ? '▾' : '▸'}</span>
                        </button>
                    </td>
                {/if}
                {@render row(item)}
            </tr>
            {#if detail && open.has(item.id)}
                <tr class="detail-row">
                    <td colspan={span}>{@render detail(item)}</td>
                </tr>
            {/if}
        {/each}
    </tbody>
</table>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin: var(--space-3) 0;
    }
    /* The <td>s come from the parent's `row` snippet, so they carry the PARENT's
       scope, not this component's — reach them with :global inside the
       component-scoped `table` (which keeps the rules from leaking app-wide). */
    table :global(th),
    table :global(td) {
        padding: var(--space-2) var(--space-3);
        border-bottom: 1px solid var(--color-border);
        text-align: left;
        vertical-align: top;
    }
    table :global(thead th) {
        border-bottom: 2px solid var(--color-border);
        white-space: nowrap;
    }
    table :global(tbody tr:hover) {
        background: var(--color-bg);
    }
    /* sortable header: reads as a bold label, not a chrome button */
    .sort {
        display: inline-flex;
        align-items: center;
        gap: var(--space-1);
        background: none;
        border: none;
        padding: 0;
        margin: 0;
        font: inherit;
        font-weight: 600;
        color: inherit;
        cursor: pointer;
    }
    .sort:hover {
        color: var(--color-accent);
    }
    /* expander column: as narrow as its content */
    .expander-col {
        width: 1%;
        white-space: nowrap;
    }
    .expander {
        background: none;
        border: none;
        padding: 0;
        margin: 0;
        font: inherit;
        line-height: 1;
        color: var(--color-muted);
        cursor: pointer;
    }
    .expander:hover {
        color: var(--color-accent);
    }
    /* expanded detail sits in its own tinted, full-width row */
    .detail-row td {
        background: var(--color-bg);
    }
</style>
