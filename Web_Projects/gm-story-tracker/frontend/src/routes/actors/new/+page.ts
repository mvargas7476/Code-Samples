import type { PageLoad } from './$types';
import { loadSuggestions } from '$lib/suggestions';
import type { Actor } from '$lib/types';

export const load: PageLoad = async ({ fetch }) => {
    // Only feeds the <datalist>s. loadSuggestions swallows every failure and returns [].
    return { allActors: await loadSuggestions<Actor>(fetch, '/api/actors/') };
};
