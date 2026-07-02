# FlashChat

A real-time chat app for iOS. Users register and log in with **Firebase Auth**, and messages are stored and streamed live from **Cloud Firestore** into a table view with custom sender/receiver cells.

## What it demonstrates
- Firebase Auth (email/password register and login)
- Real-time messaging with Cloud Firestore
- `UITableView` with custom cells and a `Message` model
- Multiple view controllers (Welcome / Login / Register / Chat) and navigation
- Constants centralized in `K.swift` / `Constants.swift`

## Tech
Swift · UIKit · Firebase (Auth, Firestore) · CocoaPods · IQKeyboardManager

## Setup & run
The `Pods/` directory and `GoogleService-Info.plist` are intentionally **not committed**.
1. `cd` into this folder and run `pod install`.
2. Create a Firebase project, enable Email/Password auth and Firestore, and download your own `GoogleService-Info.plist` into `Flash Chat iOS13/`.
3. Open `Flash Chat iOS13.xcworkspace` (not the `.xcodeproj`) and run.

> Built while completing The App Brewery *iOS & Swift* bootcamp; the Swift logic is my own, storyboards and assets are course-provided.
