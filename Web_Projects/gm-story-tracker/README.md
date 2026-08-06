# GM Note Tracker

A local web app for tabletop RPG Game Masters. It organizes campaign prep — plot structure, actors
(NPCs / adversaries / PCs), environments, and puzzles — around story **Acts**, so everything needed to
run a session is one screen away.

**Stack:** PostgreSQL (Docker) · Django + Django REST Framework · SvelteKit

Per-layer docs: **[backend/README.md](backend/README.md)** (Django commands) ·
**[frontend/README.md](frontend/README.md)** (SvelteKit commands).

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- Only if you run the app natively instead of in Docker:
  - Python 3.12+ (required by Django 6.0)
  - Node.js 20.19+ (required by Vite 8; Node 18 is end-of-life)

## Configuration

Both Docker Compose and Django read a `.env` in the repo root (it's gitignored — you supply your own).
Copy the template and fill in your own values:

```bash
cp env.example .env
```

```env
# Database credentials
POSTGRES_DB=gmTools
POSTGRES_USER=your_user
POSTGRES_PASSWORD=your_password

# Django admin user — auto-created when the backend container starts
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_PASSWORD=your_admin_password
DJANGO_SUPERUSER_EMAIL=admin@example.com
```

> `POSTGRES_HOST` is **not** set here — Compose points the backend at the `database` service, and native
> runs fall back to `localhost` (see [backend/README.md](backend/README.md)).

## Run everything with Docker

One command builds and starts the whole stack:

```bash
docker compose up --build
```

| Service    | Container           | URL                     | Notes                                                        |
| ---------- | ------------------- | ----------------------- | ------------------------------------------------------------ |
| `database` | `gm-notes-database` | localhost:5432          | Postgres 17; data persists in the `db_data` volume           |
| `backend`  | `gm-notes-backend`  | http://localhost:8000   | Django; runs migrations + creates the admin user on start    |
| `frontend` | `gm-notes-frontend` | http://localhost:5173   | SvelteKit; proxies `/api` to the backend                     |

Then open:

- The app — http://localhost:5173
- The Django admin — http://localhost:8000/admin (log in with the `DJANGO_SUPERUSER_*` credentials)

How it fits together: the database comes up first and the backend waits for it to be healthy before
migrating; the frontend proxies `/api` calls to the backend over the Compose network. The backend and
frontend bind-mount your working copy, so code edits **hot-reload** with no rebuild.

Stop with `Ctrl-C`, or from another terminal:

```bash
docker compose down        # stop and remove containers (keeps the database volume)
docker compose down -v     # also delete the db_data volume (wipes the database)
```

Run one-off commands inside a running container (e.g. Django management commands):

```bash
docker compose exec backend python manage.py <command>
```

### After changing dependencies

The frontend container keeps its `node_modules` in an anonymous volume so the macOS bind mount can't
clobber the Linux-built packages. That volume is **reused across runs**, so after adding an npm
dependency, rebuild *and* refresh the volume or the container will keep serving the old packages:

```bash
docker compose up --build --renew-anon-volumes
```

`--renew-anon-volumes` discards the stale volume so the freshly built `node_modules` is used. Don't
use `docker compose down -v` for this — it also wipes the `db_data` volume and deletes your database.

After adding a Python dependency (`requirements.txt`), rebuild the backend image so the new package is
installed — its dependencies are baked into the image, not mounted:

```bash
docker compose up --build
```

## Run natively (without Docker)

Prefer running the backend and frontend directly (e.g. for step-through debugging)? Start **only** the
database in Docker and run the rest on your machine.

**1. Start the database:**

```bash
docker compose up -d database
```

**2. Backend** — see [backend/README.md](backend/README.md) for the full command reference:

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

API at http://127.0.0.1:8000, admin at http://127.0.0.1:8000/admin.

**3. Frontend** (in a second terminal) — see [frontend/README.md](frontend/README.md):

```bash
cd frontend
npm install
npm run dev
```

App at http://localhost:5173. It proxies `/api` to Django, so the backend and database must be running.

## Project layout

```
.
├── docker-compose.yml   # full stack: database + backend + frontend
├── env.example          # template — copy to .env and fill in
├── .env                 # your credentials (gitignored — create your own)
├── backend/             # Django + DRF API   (see backend/README.md)
└── frontend/            # SvelteKit app       (see frontend/README.md)
```
