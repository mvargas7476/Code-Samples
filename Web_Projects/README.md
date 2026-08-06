# Web Projects

Full-stack and front-end web work — applications where the browser is the interface, whether that's a
complete stack wired end to end (database → API → UI) or standalone front-end development.

## Projects

| Project | Description |
|---------|-------------|
| [GM Story Tracker](gm-story-tracker/) | Full-stack campaign-prep app for tabletop RPG Game Masters — organizes adventures, story acts, actors (NPCs / adversaries / PCs), environments, and puzzles around a shared timeline. Django REST API + SvelteKit SPA over PostgreSQL, with the whole stack orchestrated by Docker Compose |

## GM Story Tracker at a glance

A three-service Docker Compose stack — PostgreSQL, a Django + DRF API, and a SvelteKit frontend that
proxies `/api` to the backend. Worth calling out:

- **Relational data modeling** — six models with foreign keys and many-to-many joins (an Act links
  actors, environments, and puzzles), plus `JSONField` columns for open-ended stat blocks and features.
- **REST API design** — DRF `ModelViewSet`s behind a `DefaultRouter`, with separate list and detail
  serializers and `prefetch_related` to avoid N+1 queries on nested reads.
- **Typed, modern frontend** — Svelte 5 in runes mode with TypeScript, file-based routing, SSR data
  loading, and reusable card / form / table components. Type-checks clean under `svelte-check`.
- **Containerized dev environment** — one `docker compose up --build` brings up the database, runs
  migrations, seeds an admin user, and starts both servers with hot reload via bind mounts.

Setup, configuration, and the full command reference live in the project's own
[README](gm-story-tracker/README.md), with per-layer docs for the
[backend](gm-story-tracker/backend/README.md) and [frontend](gm-story-tracker/frontend/README.md).

## Technologies

- **Frontend**: SvelteKit, Svelte 5 (runes), TypeScript, Vite, HTML5, CSS3
- **Backend**: Python, Django, Django REST Framework
- **Database**: PostgreSQL (psycopg 3)
- **Infrastructure**: Docker, Docker Compose
- **Tooling**: ESLint, Prettier, svelte-check
