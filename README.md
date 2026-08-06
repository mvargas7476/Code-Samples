# Code Samples — Matias Vargas

A portfolio of hands-on software projects across multiple languages, frameworks, and platforms — from mobile apps and backend APIs to machine-learning models built from scratch and classic design-pattern implementations. It's meant to give prospective employers a fast read on technical breadth, code style, and how I approach problems.

## About

I'm a **Senior Software Engineer with 6 years of experience**, working across the full stack — frontend, backend, and databases. I came to software from education: I taught Robotics and Programming at a junior high in the Dallas–Fort Worth area, and it was there that I discovered how much I enjoyed building software and decided to change careers. The move built on a Minor in Software Development, and along the way I earned a Master's in Software Engineering.

The projects here span independent work, graduate coursework, and guided builds I used to pick up new stacks. The **Highlights** below point to the most substantial, original pieces.

## Highlights

- **[Full Stack — GM Story Tracker](Web_Projects/gm-story-tracker/)** — campaign-prep app for tabletop RPG Game Masters, built as a three-service Docker Compose stack: a Django REST Framework API over PostgreSQL and a typed SvelteKit SPA. Relational modeling across six related models, `ModelViewSet`s with `prefetch_related` to avoid N+1 reads, and Svelte 5 runes with SSR data loading — `docker compose up --build` brings up the database, migrations, and both servers with hot reload.
- **[Go — Event Booking API](Go_Projects/05_event_booking/)** — REST API with JWT auth, bcrypt password hashing, protected route groups, and SQLite persistence, organized into routes / models / middleware / utils layers.
- **[Go — Concurrent Price Calculator](Go_Projects/04_price_calc/)** — idiomatic concurrency with goroutines, channels, and `select`, plus an `IOManager` interface with file and CLI implementations (dependency injection).
- **[Flutter — Chat App](Flutter_Projects/07_chat_app/)** & **[Favorite Places](Flutter_Projects/06_favorite_places_app/)** — a full-stack Firebase Auth + Firestore chat app, and a device-integrated app using camera, geolocation, Google Maps, and an on-device SQLite store.
- **[Python — Tom's Data Onion](Python_Projects/Toms_Data_Onion/)** — from-scratch solutions to a 7-layer decoding puzzle, including a small bytecode VM/emulator — alongside a neural network and a linear-regression model implemented from scratch with NumPy.

## Projects

| Folder | Description | Technologies |
|--------|-------------|--------------|
| [Flutter_Projects/](Flutter_Projects/) | 7 cross-platform mobile apps, progressing from basic UI to full-stack Firebase and device-feature apps | Flutter, Dart, Riverpod, Firebase, SQLite |
| [Go_Projects/](Go_Projects/) | 5 Go projects spanning CLI tools, concurrency, and a REST API with JWT auth | Go, Gin, SQLite, JWT |
| [Java_Projects/](Java_Projects/) | Object-oriented design-pattern implementations (Factory, Strategy, State) | Java |
| [Python_Projects/](Python_Projects/) | Machine-learning models built from scratch, a data-generation pipeline, and low-level decoding puzzles | Python, NumPy, Pandas, scikit-learn |
| [Web_Projects/](Web_Projects/) | Full-stack web work — a dockerized Django REST + SvelteKit campaign tracker for tabletop RPG Game Masters | Django, DRF, SvelteKit, TypeScript, PostgreSQL, Docker |
| [iOS-Applications/](iOS-Applications/) | 9 native iOS apps built while completing an iOS & Swift bootcamp | Swift, UIKit, AVFoundation, Firebase |

## Technology Experience

### Demonstrated in this repository
- **Languages:** Go, Java, Python, Dart, Swift, TypeScript, JavaScript, HTML/CSS
- **Frameworks & libraries:** Flutter, Gin, Django, Django REST Framework, SvelteKit, Riverpod, Vite
- **Databases & backends:** PostgreSQL, SQLite, Firebase (Auth, Firestore, Realtime Database), MySQL
- **Infrastructure:** Docker, Docker Compose

### Also experienced with (professional work)
- **Languages:** C#, Kotlin, PHP, Node.js
- **Frameworks:** React, Laravel
- **Databases:** SQL Server, MongoDB
- **Cloud:** AWS, Firebase, Azure
- **IaC:** Terraform
- **AI:** ClaudeCode, Codex, Bedrock, OpenClaw, Hermes

### Operating systems
macOS · Linux · Windows
