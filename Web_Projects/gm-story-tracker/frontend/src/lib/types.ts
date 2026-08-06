export type ActorKind = 'npc' | 'adversary' | 'pc';
export type PuzzleStatus = 'draft' | 'ready';
export type SolutionType = 'correct' | 'alternate' | 'red_herring';
export type AdventureStatus = 'planning' | 'active' | 'completed' | 'archived';

// Setting up interfaces of the data type that will come back
export interface Adventure {
    id: number;
    title: string;
    story_setting: string;
    description: string;
    status: AdventureStatus;
    created_at: string;
    updated_at: string;
}

export interface Actor {
    id: number;
    name: string;
    kind: ActorKind;
    motivation: string;
    description: string;
    tier: string;
    actor_type: string;
    factions: string[];
    notes: string;
    stats: Record<string, unknown>; // This is free form JSON
    abilities: Record<string, unknown>;
    features: Array<Record<string, unknown>>;
    created_at: string;
    updated_at: string;
}

export interface Environment {
    id: number;
    name: string;
    description: string;
    sensory_details: string;
    hazards: string;
    secrets: string;
    notes: string;
    tier: string;
    environment_type: string;
    created_at: string;
    updated_at: string;
}

export interface PuzzleSolution {
    id: number;
    tier: number | null;
    solution_type: SolutionType;
    description: string;
    notes: string;
}

export interface Puzzle {
    id: number;
    name: string;
    description: string;
    notes: string;
    status: PuzzleStatus;
    solutions: PuzzleSolution[];
    created_at: string;
    updated_at: string;
}

export interface ActDetail {
    id: number;
    adventure: number;
    order: number;
    title: string;
    summary: string;
    plot_hooks: string;
    story_beats: string;
    climax: string;
    gm_notes: string;
    actors: Actor[];
    environments: Environment[];
    puzzles: Puzzle[];
    created_at: string;
    updated_at: string;
}

export interface ActSummary {
    id: number;
    order: number;
    title: string;
    summary: string;
}

export interface AdventureDetail extends Adventure {
    acts: ActSummary[];
}
