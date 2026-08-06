import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { Puzzle } from '$lib/types';

export const load: PageLoad = async ({ fetch, params }) => {
    const res = await fetch(`/api/puzzles/${params.id}/`);
    if (!res.ok) error(res.status, 'Failed to load puzzle');
    const puzzle: Puzzle = await res.json();
    return { puzzle };
};
