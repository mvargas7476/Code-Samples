import 'package:favorite_places_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserPlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    // This is here because we can't edit the old state with Riverpod
    return const [];
  }

  Future<Database> _getDatabase() async {
    // Now we want to save the data using the SQL database. This is in the device
    final dbPath = await sql.getDatabasesPath(); // This points to a directory that has databases that we can create
    final db = await sql.openDatabase(path.join(dbPath, 'places.db'), 
      onCreate: (db, version) {
        return db.execute('CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      },
      version: 1,
    ); // This either opens the database or creates it
    return db;
  }


  Future<void> loadPLaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places'); // We just want everything right now so they load for the user  

    final places = data.map((row) => Place(
      id: row['id'] as String, 
      title: row['title'] as String, 
      image: File(row['image'] as String), 
      location: PlaceLocation(
        latitude: row['lat'] as double, 
        longitude: row['lng'] as double, 
        address: row['address'] as String)
      )
    ).toList();

    state = places;
  }

  // Adding a new place to the list
  void addPlace(String title, File image, PlaceLocation location) async {
    // Using these to be able to save the image to a more secure place that persists
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Place(title: title, image: copiedImage, location: location);

    final db = await _getDatabase();

    // This does all of the inset needed
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider = NotifierProvider<UserPlacesNotifier, List<Place>>(UserPlacesNotifier.new);