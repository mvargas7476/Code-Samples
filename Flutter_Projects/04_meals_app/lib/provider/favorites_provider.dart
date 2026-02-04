import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
// Needed for the old version
// import 'package:flutter_riverpod/legacy.dart';

// This is the new way of doing it with RiverPod
// This Is a better way or working with changing lists
class FavoriteMealsNotifier extends Notifier<List<Meal>> {
  // we really do not want to edit these values. So we need to make new ones
  @override
  List<Meal> build() {
    return [];
  }

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if(mealIsFavorite) {
      // Remember that where returns a new list so this works
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // This copies all of the current values, and then we add the new meal
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider = NotifierProvider<FavoriteMealsNotifier, List<Meal>>(FavoriteMealsNotifier.new);


// Here is the old way
// class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
//   // we really do not want to edit these values. So we need to make new ones
//   FavoriteMealsNotifier(): super([]);

//   void toggleMealFavoriteStatus(Meal meal) {
//     final mealIsFavorite = state.contains(meal);

//     if(mealIsFavorite) {
//       // Remember that where returns a new list so this works
//       state = state.where((m) => m.id != meal.id).toList();
//     } else {
//       // This copies all of the current values, and then we add the new meal
//       state = [...state, meal];
//     }
//   }
// }

// final favoriteMeals = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
//   return FavoriteMealsNotifier();
// });