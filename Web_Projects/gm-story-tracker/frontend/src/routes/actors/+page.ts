import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { Actor } from '$lib/types';

export const load: PageLoad = async ({ fetch }) => {
    const res = await fetch(`/api/actors/`);

    if (!res.ok) {
        error(res.status, 'Failed to load actors');
    }

    // If everything success, the responce should follow the Actor structure
    const actors: Actor[] = await res.json();
    return { actors };
};
