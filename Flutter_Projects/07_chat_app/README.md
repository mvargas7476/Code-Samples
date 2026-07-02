# Chat App

A real-time chat app built on Firebase. Users sign up and log in with **Firebase Auth** (email/password), and messages are stored and streamed live from **Cloud Firestore**. A splash screen gates the UI on auth state, and the goal of the project was to wire multiple Firebase SDKs together into a clean auth-and-messaging flow.

## What it demonstrates
- Firebase Auth (email/password sign-up and login)
- Real-time messaging with Cloud Firestore streams
- Auth-state gating with a splash screen
- Form validation and error handling
- Message-bubble UI with per-user styling

## Tech
Flutter · Dart · firebase_core · firebase_auth · cloud_firestore

## Setup & run
This app requires your own Firebase project. Configure FlutterFire (`flutterfire configure`) to generate `lib/firebase_options.dart`, and add the platform config files (`google-services.json` / `GoogleService-Info.plist`) — these are git-ignored and not committed.
```bash
flutter pub get
flutter run
```
