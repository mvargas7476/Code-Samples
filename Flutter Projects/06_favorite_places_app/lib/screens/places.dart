import 'package:favorite_places_app/providers/user_provider.dart';
import 'package:favorite_places_app/screens/add_place.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}


class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPLaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()));
            }, 
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // We only want to display this if everything is gotten from the DB
        child: FutureBuilder(
          future: _placesFuture, 
          builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting 
            ? const Center(child: CircularProgressIndicator()) 
            : PlacesList(
              places: userPlaces
            ),
        ) 
      ),
    );
  }
}