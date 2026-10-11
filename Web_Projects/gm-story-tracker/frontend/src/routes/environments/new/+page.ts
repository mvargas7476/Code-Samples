import type { PageLoad } from './$types';
import { loadSuggestions } from '#lib/suggestions.ts';
import type { Environment } from '#lib/types.ts';

export const load: PageLoad = async ({ fetch }) => {
    // Only feeds the <datalist>s. loadSuggestions swallows
    // every failure and returns [].
    return { allEnvironments: await loadSuggestions<Environment>(fetch, '/api/environments/') };
};
