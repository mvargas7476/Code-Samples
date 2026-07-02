# ByteCoin

A live cryptocurrency price tracker. Pick a currency and the app fetches the current Bitcoin price from the [CoinAPI](https://www.coinapi.io) REST API and displays it.

## What it demonstrates
- Networking with `URLSession`
- JSON parsing with `Codable` / `JSONDecoder` (`CoinData`, `CurrencyData`)
- The delegate pattern (`CoinManagerDelegate`) for async callbacks and error handling
- A `UIPickerView`-driven UI

## Tech
Swift · UIKit · URLSession · Codable

## Setup & run
The API key is loaded from a git-ignored `Secrets.plist` instead of being hard-coded.
1. Get a free key at [coinapi.io](https://www.coinapi.io).
2. Copy `ByteCoin/Secrets.example.plist` to `ByteCoin/Secrets.plist` and set `COINAPI_KEY`.
3. In Xcode, add `Secrets.plist` to the ByteCoin target (Target Membership) so it's bundled, then run.

> Built while completing The App Brewery *iOS & Swift* bootcamp; the Swift logic is my own, storyboards and assets are course-provided.
