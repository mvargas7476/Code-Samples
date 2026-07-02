# iOS Applications

9 native iOS apps built in Swift with Xcode, progressing from simple UI exercises to apps with networking, audio playback, and real-time chat. All use UIKit and follow the MVC pattern.

> **Attribution:** These were built while completing the *iOS & Swift* bootcamp by The App Brewery (Angela Yu). The Swift logic and model code are my own; the storyboards, image assets, and project scaffolding are course-provided. They're included here as learning exercises that show progression across UIKit, networking, and Firebase.

## Apps

| # | App | Description |
|---|-----|-------------|
| 1 | [I Am Rich](1_I-am-Rich/) | Introductory app — basic UI layout and asset management |
| 2 | [Xylophone](2_Xylophone/) | Plays musical notes via buttons using AVFoundation audio |
| 3 | [Egg Timer](3_EggTimer/) | Countdown timer with a progress bar for different egg types |
| 4 | [Quizzler](4_Quizzler/) | True/false quiz app with score tracking and UI feedback (MVC `QuizBrain`) |
| 5 | [Destini](5_Destini/) | Choose-your-own-adventure story app with branching logic |
| 6 | [BMI Calculator](6_BMI-Calculator/) | Calculates and interprets BMI across a multi-screen flow |
| 7 | [Tipsy](7_Tipsy/) | Bill-splitting and tip calculator |
| 8 | [ByteCoin](8_ByteCoin/) | Live cryptocurrency price tracker — `URLSession` + `Codable` with a delegate pattern |
| 9 | [FlashChat](9_FlashChat/) | Real-time chat app with Firebase Auth and Firestore |

## Running the networked apps

- **ByteCoin** needs a free [CoinAPI](https://www.coinapi.io) key. Copy `8_ByteCoin/ByteCoin/Secrets.example.plist` to `Secrets.plist`, add your key under `COINAPI_KEY`, and add the file to the app target. `Secrets.plist` is git-ignored.
- **FlashChat** uses CocoaPods and Firebase. Run `pod install` in `9_FlashChat/` (the `Pods/` directory is intentionally not committed), and add your own `GoogleService-Info.plist` from the Firebase console (also git-ignored).

## Technologies
- **Language**: Swift
- **Frameworks**: UIKit, AVFoundation
- **Networking**: URLSession, Codable / JSONDecoder
- **Backend**: Firebase (Auth, Firestore)
- **Tooling**: Xcode, CocoaPods
- **Pattern**: MVC
