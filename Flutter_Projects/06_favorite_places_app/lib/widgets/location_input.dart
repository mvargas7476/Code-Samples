import 'dart:convert';
import 'package:favorite_places_app/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:favorite_places_app/models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://googleapis..../staticmap?center=$lat,$lng=&zoom=16&size=600,300&maptypw=roadmap&key={YOUR_API_KEY}';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    // Note the next section Requires the Google Maps API, while I have set up the code I am not paying for the API
    // which means this application will be useless for a lot of it. But it has been really goog learning
    final url = Uri.parse('https://maps.googleapis...?key={YOUR__API_KEY}&latlng=$latitude,$longitude');
    final response = await http.get(url);
    final respData = json.decode(response.body);
    final address = respData['results'][0]['formatted_address'];
    
    setState(() {
      _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    // Focusing on device features so no worries about error handling
    if (lat == null || lng == null) {
      return;
    }

    // If everything is good 
    _savePlace(lat, lng);
  }

  void _selectOnMap() async {
    // Doign this here so that we wait for things to come back from the MapScreen
    final pickedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx) => const MapScreen()));

    if (pickedLocation == null) {
      return;
    }

    _savePlace(pickedLocation.latitude, pickedLocation.longitude);

  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location Chosen', 
      textAlign: TextAlign.center, 
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface
      )
    );

    if(_pickedLocation != null) {
      previewContent = Image.network(locationImage, fit: BoxFit.cover, width: double.infinity, height: double.infinity,);
    }

    if(_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)),
          ),
          child: previewContent
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation, 
              icon: const Icon(Icons.location_on), 
              label: const Text('Get Current Location')
            ),
            TextButton.icon(
              onPressed: _selectOnMap, 
              icon: const Icon(Icons.location_on), 
              label: const Text('Select on Map')
            ),
          ],
        )
      ],
    );
  }
}