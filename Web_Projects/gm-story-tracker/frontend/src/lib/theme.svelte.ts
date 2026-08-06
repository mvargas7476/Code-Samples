import { browser } from '$app/environment';

export type Theme = 'light' | 'dark';

// Keep this key and the "default to dark" rule in sync with the pre-paint script in
// src/app.html — that script can't import this module (it runs before the bundle loads).
const STORAGE_KEY = 'gm-theme';

function initialTheme(): Theme {
    // Setting the color to dark by default, since there is no storage while starting the app
    if (!browser) return 'dark';
    // localStorage access can throw (sandboxed/disabled storage); fall back to dark.
    try {
        const saved = localStorage.getItem(STORAGE_KEY);
        return saved === 'light' || saved === 'dark' ? saved : 'dark';
    } catch {
        return 'dark';
    }
}

// Adding reactive module that stays mutable wherever in the app you are
export const theme = $state<{ value: Theme }>({ value: initialTheme() });

export function toggleTheme() {
    theme.value = theme.value === 'dark' ? 'light' : 'dark';
}

// Reflect the theme onto <html> and persist it. Called from the layout's $effect.
export function applyTheme(t: Theme) {
    if (!browser) return;
    document.documentElement.setAttribute('data-theme', t);
    // setItem can throw (quota/disabled storage) — the attribute still applies, so just skip persisting.
    try {
        localStorage.setItem(STORAGE_KEY, t);
    } catch {
        // ignore: theme is applied for this session, just not persisted
    }
}
