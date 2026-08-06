// How freeform/enum values are turned into text for the screen. One home, because the same actor
// shows up on the list page, in an expanded card, and on the Act Detail summary line — and those
// three had drifted into rendering the same field three different ways.

import type { Actor, ActorKind, Environment, PuzzleStatus } from '$lib/types';

/** Human labels for `kind`. The API value is lowercase; nothing should render it raw. */
export const KIND_LABEL: Record<ActorKind, string> = {
    npc: 'NPC',
    adversary: 'Adversary',
    pc: 'Player Character'
};

export const PUZZLE_STATUS_LABEL: Record<PuzzleStatus, string> = {
    draft: 'Draft',
    ready: 'Ready'
};

/**
 * Prefix "Tier " only when the GM hasn't already typed it. Tier is freeform text — "2", "2-3",
 * "any", or "Tier II" — so a hardcoded prefix turns the last one into "Tier Tier II".
 * Whitespace-only returns '' rather than a dangling "Tier ".
 */
export function tierLabel(tier: string): string {
    const t = tier.trim();
    if (!t) return '';
    return /^tier\b/i.test(t) ? t : `Tier ${t}`;
}

// One-line labels for the Act Detail page — <summary> lines and the link-a-thing <option>s.
// Factions stay out: plural, unbounded, and wanted on expand instead.
export function actorLine(a: Actor): string {
    const meta = [tierLabel(a.tier), a.actor_type].filter(Boolean);
    return `${a.name} — ${KIND_LABEL[a.kind]}${meta.length ? ` · ${meta.join(' · ')}` : ''}`;
}

export function environmentLine(e: Environment): string {
    const meta = [tierLabel(e.tier), e.environment_type].filter(Boolean);
    return meta.length ? `${e.name} · ${meta.join(' · ')}` : e.name;
}
