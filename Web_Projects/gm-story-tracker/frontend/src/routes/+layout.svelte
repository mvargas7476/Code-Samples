<script lang="ts">
    import '../app.css';
    import favicon from '$lib/assets/favicon.svg';
    import { page } from '$app/state';
    import { theme, toggleTheme, applyTheme } from '$lib/theme.svelte';

    let { children } = $props();

    const path = $derived(page.url.pathname);

    // Reflect the selected theme onto <html> and persist it whenever it changes.
    $effect(() => applyTheme(theme.value));

    // `match` decides which tab is "active" for the current path.
    // Adventures also covers /adventures/* and /acts/* since those are adventure content.
    const navItems = [
        {
            href: '/',
            label: 'Adventures',
            match: (p: string) => p === '/' || p.startsWith('/adventures') || p.startsWith('/acts')
        },
        { href: '/actors', label: 'Actors', match: (p: string) => p.startsWith('/actors') },
        { href: '/environments', label: 'Environments', match: (p: string) => p.startsWith('/environments') },
        { href: '/puzzles', label: 'Puzzles', match: (p: string) => p.startsWith('/puzzles') }
    ];
</script>

<svelte:head>
    <link rel="icon" href={favicon} />
</svelte:head>

<nav>
    {#each navItems as item (item.href)}
        <a href={item.href} class:active={item.match(path)}>{item.label}</a>
    {/each}
    <button
        type="button"
        class="theme-toggle"
        class:dark={theme.value === 'dark'}
        role="switch"
        aria-checked={theme.value === 'dark'}
        aria-label="Dark theme"
        onclick={toggleTheme}
    >
        <span class="glyph sun" aria-hidden="true">☀</span>
        <span class="glyph moon" aria-hidden="true">☾</span>
        <span class="knob" aria-hidden="true">{theme.value === 'dark' ? '☾' : '☀'}</span>
    </button>
</nav>

{@render children()}

<style>
    /* Nav links read as muted; the current section pops in the accent color. */
    nav a {
        color: var(--color-muted);
    }
    nav a.active {
        color: var(--color-accent);
        font-weight: 600;
    }
    /* Sliding theme switch, pushed to the far right of the nav row. */
    .theme-toggle {
        margin-left: auto;
        flex: none;
        position: relative;
        width: 3.5rem;
        height: 1.9rem;
        padding: 0;
        border-radius: 999px;
        background: var(--color-surface);
    }
    .theme-toggle .glyph {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        font-size: 0.7rem;
        line-height: 1;
        color: var(--color-muted);
    }
    .theme-toggle .sun {
        left: 0.45rem;
    }
    .theme-toggle .moon {
        right: 0.45rem;
    }
    .theme-toggle .knob {
        position: absolute;
        top: 50%;
        left: 0.2rem;
        transform: translateY(-50%);
        display: flex;
        align-items: center;
        justify-content: center;
        width: 1.3rem;
        height: 1.3rem;
        border-radius: 50%;
        font-size: 0.7rem;
        background: var(--color-accent);
        color: var(--color-accent-text);
        transition: left 0.15s ease;
    }
    .theme-toggle.dark .knob {
        left: calc(100% - 1.3rem - 0.2rem);
    }
</style>
