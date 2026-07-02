# Favorite Places

Save favorite places, each with a photo taken from the camera and the current GPS location shown on a Google Map. Places persist to an on-device **SQLite** database, and captured images are copied into the app's documents directory.

## What it demonstrates
- Device features: camera (`image_picker`), geolocation (`location`), maps (`google_maps_flutter`)
- On-device persistence with `sqflite` (CRUD via a Riverpod `Notifier`)
- File handling with `path` / `path_provider`
- Model/screen/widget separation

## Tech
Flutter · Dart · flutter_riverpod · google_maps_flutter · image_picker · location · sqflite

## Setup & run
> **Note:** The Google Maps API key has been removed to avoid billing, so the **map view will not render** without your own key. Photo capture, location capture, and the SQLite store all still work. Add a Google Maps API key (in the Android/iOS platform config) to enable maps.
```bash
flutter pub get
flutter run
```
