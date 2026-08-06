# GM Note Tracker — backend

Django + Django REST Framework. The Django **project** is `config/`; all models, serializers, and views
live in a single app, **`campaigns/`**. DRF exposes the REST API the SvelteKit frontend consumes, and the
Django admin gives near-free CRUD.

- **Database:** PostgreSQL 17 (via Docker), using the **psycopg 3** driver (`psycopg[binary]`).
- **Config:** `config/settings.py` loads the repo-root `.env` with `python-dotenv` — **Django does not read
  `.env` on its own.** The DB connection reads `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD` (required)
  and `POSTGRES_HOST` / `POSTGRES_PORT` (default `localhost` / `5432`).

## Running commands: two options

**Natively** — from this `backend/` folder with the virtualenv active. `POSTGRES_HOST` defaults to
`localhost`, so the database must be reachable on the host (`docker compose up -d database`):

```bash
python manage.py <command>
```

**Inside the running container** — Compose sets `POSTGRES_HOST=database` for you:

```bash
docker compose exec backend python manage.py <command>
```

The command reference below is written as `python manage.py …`; prefix it with `docker compose exec
backend` to run it in the container instead.

## One-time setup (native)

```bash
python3 -m venv .venv           # create the virtual environment
source .venv/bin/activate       # activate it (do this every new shell)
pip install -r requirements.txt # install Django, DRF, psycopg, python-dotenv, …
deactivate                      # leave the virtualenv when done
```

Add a dependency: `pip install <pkg>` then `pip freeze > requirements.txt` (rebuild the image for Docker —
see the root README).

## Dev server

```bash
python manage.py runserver              # http://127.0.0.1:8000 (admin at /admin)
python manage.py runserver 0.0.0.0:8000 # bind all interfaces (what the container uses)
```

## Migrations

Django tracks schema changes as migration files; you author them from model changes, then apply them.

```bash
python manage.py makemigrations campaigns   # generate migrations for model changes in the app
python manage.py migrate                     # apply all pending migrations to the database
python manage.py showmigrations              # list migrations and which are applied ([X] = applied)
python manage.py sqlmigrate campaigns 0001   # print the SQL a migration would run (doesn't execute)
python manage.py migrate campaigns 0002      # migrate the app to a specific migration (up or down)
```

## Admin user

```bash
python manage.py createsuperuser            # interactive: prompts for username / email / password
python manage.py createsuperuser --noinput  # non-interactive: reads DJANGO_SUPERUSER_USERNAME /
                                             # _PASSWORD / _EMAIL from the environment (Docker uses this)
python manage.py changepassword <username>  # reset a user's password
```

The Docker backend runs `createsuperuser --noinput || true` on start, so the admin user is created
automatically (and silently skipped once it exists).

## Shell & database

```bash
python manage.py shell        # Python REPL with Django loaded (query the ORM, poke at models)
python manage.py dbshell      # open psql against the configured database
python manage.py test         # run the test suite
python manage.py test campaigns.tests.SomeTest   # run a single test / case
```

## Inspecting the project

```bash
python manage.py check                 # system checks (misconfig, model errors) without running
python manage.py showmigrations        # migration state (see above)
python manage.py diffsettings          # settings that differ from Django defaults
python manage.py startapp <name>       # scaffold a new app (this project uses a single app: campaigns)
python manage.py collectstatic         # gather static files — deployment only; not needed in dev
```

## Layout

```
backend/
├── manage.py          # Django CLI entry point
├── requirements.txt   # Python dependencies
├── Dockerfile         # backend image (migrate → createsuperuser → runserver)
├── config/            # project: settings.py, urls.py, wsgi.py, asgi.py
└── campaigns/         # the app: models, serializers, views, admin, migrations
```
