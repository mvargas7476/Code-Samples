import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

// Using the Provider class here since dummyMeals never changes
final mealsProvider = Provider((ref) {
  return dummyMeals;
});