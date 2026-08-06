import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import type { ActDetail, Actor, Environment, Puzzle } from '$lib/types';

export const load: PageLoad = async ({ params, fetch }) => {
    const [actsRes, actorsRes, environmentsRes, puzzlesRes] = await Promise.all([
        fetch(`/api/acts/${params.id}/`),
        fetch(`/api/actors/`),
        fetch(`/api/environments/`),
        fetch(`/api/puzzles/`),
    ]);

    // The act itself IS the "at the table" screen — if it can't load, the page can't render.
    if (actsRes.status == 404) {
        error(404, 'Act not found');
    }
    if (!actsRes.ok) {
        error(actsRes.status, 'Failed to load act');
    }

    const act: ActDetail = await actsRes.json();

    // These three lists only feed the "Edit Components" link dropdowns (a prep-time action).
    // Viewing the act must not depend on them, so a failed list degrades to empty rather than
    // taking down the whole screen during live play.
    const allActors: Actor[] = actorsRes.ok ? await actorsRes.json() : [];
    const allEnvironments: Environment[] = environmentsRes.ok ? await environmentsRes.json() : [];
    const allPuzzles: Puzzle[] = puzzlesRes.ok ? await puzzlesRes.json() : [];

    return { act, allActors, allEnvironments, allPuzzles };
};
