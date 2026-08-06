# GM Note Tracker — frontend

The SvelteKit app: **TypeScript**, **Svelte 5 runes mode** (forced in `vite.config.ts`), file-based routing
under `src/routes/`. It talks to the Django API through a Vite dev proxy that forwards `/api` to the
backend, so the backend and database must be running too.

- **Proxy target:** `API_PROXY_TARGET` (set by Docker Compose to `http://backend:8000`); falls back to
  `http://127.0.0.1:8000` for native runs. Configured in `vite.config.ts`.
- **Types:** `.svelte-kit/` is generated — SvelteKit regenerates it via `svelte-kit sync` (run by
  `prepare` and `check`). It's safe to delete; it'll be rebuilt.

See the [root README](../README.md) for full setup.

## Running commands: two options

**Natively** — from this `frontend/` folder:

```bash
npm install
npm run <script>
```

**Inside the running container:**

```bash
docker compose exec frontend npm run <script>
```

## Commands

```bash
npm run dev        # start the Vite dev server at http://localhost:5173 (HMR)
npm run build      # production build (via adapter-auto)
npm run preview    # serve the production build locally
npm run check      # svelte-kit sync + svelte-check — TypeScript / Svelte type checking (the type gate)
npm run check:watch # same, in watch mode
npm run lint       # prettier --check + eslint
npm run format     # prettier --write (apply formatting)
```

Underlying SvelteKit tools these wrap:

- **`svelte-kit sync`** — regenerates `.svelte-kit/` (types, generated modules). Run automatically by
  `prepare` and `check`; run it by hand if editor types get stale.
- **`svelte-check`** — type-checks `.svelte` and `.ts` files against `tsconfig.json`.

> `npm run check` is the type gate and should stay clean. `npm run lint` currently reports pre-existing,
> project-wide violations that are a separate future cleanup — not per-change breakage.

## Layout

```
frontend/
├── vite.config.ts     # Vite config: runes mode + the /api dev proxy
├── svelte.config.js   # SvelteKit adapter / preprocess config
├── Dockerfile         # frontend image (npm install → npm run dev --host)
├── src/
│   ├── lib/           # shared code — API types in src/lib/types.ts
│   └── routes/        # file-based routes (e.g. routes/acts/[id]/)
└── static/            # static assets served as-is
```
