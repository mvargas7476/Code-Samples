import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { Puzzle } from '$lib/types';

export const load: PageLoad = async ({ fetch }) => {
    const res = await fetch(`/api/puzzles/`);

    if (!res.ok) {
        error(res.status, 'Failed to load puzzles');
    }

    // If everything success, the responce should follow the Puzzle structure
    const puzzles: Puzzle[] = await res.json();
    return { puzzles };
};
