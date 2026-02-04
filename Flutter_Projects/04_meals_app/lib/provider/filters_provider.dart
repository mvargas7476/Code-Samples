import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FiltersNotifier extends Notifier<Map<Filter, bool>> {
  // This is the new way to set this, but I need to lear for the short version to do this with th $Notifier
  @override
  Map<Filter, bool> build() {
    return {
      Filter.glutenFree: false, 
      Filter.lactoseFree: false, 
      Filter.vegetarian: false, 
      Filter.vegan: false
    };
  }
  
  
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider = NotifierProvider<FiltersNotifier, Map<Filter, bool>>(FiltersNotifier.new);


// Adding another provider to handle logic for filtered meals
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }
);
