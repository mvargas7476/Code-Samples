import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import { loadSuggestions } from '$lib/suggestions';
import type { Actor } from '$lib/types';

export const load: PageLoad = async ({ fetch, params }) => {
    const [res, allActors] = await Promise.all([
        fetch(`/api/actors/${params.id}/`),
        // Self-catching, so a failed suggestions list can't reject the Promise
        loadSuggestions<Actor>(fetch, '/api/actors/')
    ]);
    if (!res.ok) error(res.status, 'Failed to load actor');
    const actor: Actor = await res.json();
    return { actor, allActors };
};
