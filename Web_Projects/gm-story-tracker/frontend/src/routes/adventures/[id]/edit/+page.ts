import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { AdventureDetail } from '$lib/types';

export const load: PageLoad = async ({ fetch, params }) => {
    const res = await fetch(`/api/adventures/${params.id}/`);
    if (!res.ok) error(res.status, 'Failed to load adventure');
    const adventure: AdventureDetail = await res.json();
    return { adventure };
};