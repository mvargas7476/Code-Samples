# Shopping List

A grocery list with full create/read/delete backed by a **Firebase Realtime Database** over HTTP. Add items with a category and quantity, and delete them; the list loads from and syncs to the backend with proper loading and error states.

## What it demonstrates
- Async HTTP (`GET`/`POST`/`DELETE`) against a REST backend
- Loading, empty, and error UI states
- Form input and validation
- Model/data separation (`grocery_item`, `category`)

## Tech
Flutter · Dart · http · Firebase Realtime Database

## Setup & run
This app expects a Firebase Realtime Database URL. Create your own Firebase project, then set the database URL used by the HTTP calls in `lib/widgets/`.
```bash
flutter pub get
flutter run
```
