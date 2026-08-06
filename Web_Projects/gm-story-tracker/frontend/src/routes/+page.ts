import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { Adventure } from '$lib/types';

export const load: PageLoad = async ({ fetch }) => {
    const res = await fetch('/api/adventures/');
    if (!res.ok) error(res.status, 'Failed to load adventures');

    const adventures: Adventure[] = await res.json();
    return { adventures };
};
