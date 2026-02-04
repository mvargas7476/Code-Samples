import 'package:uuid/uuid.dart';
import 'dart:io';

// Having UUID since this is better for th id
const  uuid  = Uuid();

class PlaceLocation {
  const PlaceLocation({required this.latitude, required this.longitude, required this.address});

  final double latitude;
  final double longitude;
  final String address;

}

class Place {
  Place({required this.title, required this.image, required this.location, String? id}): id = id ?? uuid.v4(); // This at the end either gets an id or takes the one provided

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}