import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { Environment } from '$lib/types';

export const load: PageLoad = async ({ fetch }) => {
    const res = await fetch(`/api/environments/`);

    if (!res.ok) {
        error(res.status, 'Failed to load environments');
    }

    // If everything success, the responce should follow the Environment structure
    const environments: Environment[] = await res.json();
    return { environments };
};
