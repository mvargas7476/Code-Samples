import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import { loadSuggestions } from '$lib/suggestions';
import type { Environment } from '$lib/types';

export const load: PageLoad = async ({ fetch, params }) => {
    const [res, allEnvironments] = await Promise.all([
        fetch(`/api/environments/${params.id}/`),
        // Self-catching, so a failed suggestions list can't reject the Promise
        loadSuggestions<Environment>(fetch, '/api/environments/')
    ]);
    if (!res.ok) error(res.status, 'Failed to load environment');
    const environment: Environment = await res.json();
    return { environment, allEnvironments };
};
