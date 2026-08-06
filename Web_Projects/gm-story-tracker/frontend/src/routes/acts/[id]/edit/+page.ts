import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { ActDetail } from '$lib/types';

export const load: PageLoad = async ({ fetch, params }) => {
    const res = await fetch(`/api/acts/${params.id}/`);
    if (!res.ok) error(res.status, 'Failed to load act');
    const act: ActDetail = await res.json();
    return { act };
};
