# Go Projects

5 Go projects built while learning the language, covering CLI tools, file I/O, concurrency, and a full REST API with authentication. Chosen for Go's performance, simplicity, and suitability for backend development.

## Projects

| # | Project | Description |
|---|---------|-------------|
| 01 | [Investment Calc](01_investment_calc/) | Language fundamentals — a profit & tax calculator that reads revenue, expenses, and a tax rate, computes earnings-before-tax, profit, and ratio, and writes the results to a file |
| 02 | [Banking](02_banking/) | CLI banking app — check balance, deposit, and withdraw, with the balance persisted to a file through a dedicated `fileops` package |
| 03 | [Notes Taking](03_notes_taking/) | CLI note-taker — prompts for a title and body, then saves the note as a JSON file (structs, struct tags, JSON marshaling, file I/O) |
| 04 | [Price Calc](04_price_calc/) | Concurrent price calculator — computes tax-included prices across multiple rates using goroutines, channels, and `select`; writes per-rate JSON through a swappable `IOManager` interface |
| 05 | [Event Booking](05_event_booking/) | REST API for events with JWT authentication, bcrypt password hashing, protected route groups, and SQLite persistence, organized into routes / models / middleware / utils |

## Technologies
- **Language**: Go
- **Framework**: Gin (Event Booking)
- **Database**: SQLite (`mattn/go-sqlite3`)
- **Auth**: JWT (`golang-jwt/jwt`), bcrypt (`golang.org/x/crypto`)
- **Concepts**: packages, interfaces & dependency injection, goroutines/channels, JSON encoding
