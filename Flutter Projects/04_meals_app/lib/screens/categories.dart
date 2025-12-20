import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// This basically merges 2 classes in a way. the second is for an Explicit Animation
class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  // late is a keywqord for things that will later have a value but not at first
  late AnimationController _animationController;

  // Always we start the in the init
  // which is run ONLY when the widget is created
  @override
  void initState() {
    super.initState();

    // This created the animation
    _animationController = AnimationController(
      vsync: this, // We set it to this since the class has the Ticker Provider
      duration: Duration(milliseconds: 300),
      lowerBound: 0, // In animation you are always animating between two bounds
      upperBound: 1,
    );

    // This actually runs the animation
    _animationController.forward();
  }
  
  // Disposing the animation since we don't want to overload memory on a device
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // Looking at dummy data and keeping the meals that have the right ids
    final filteredList = widget.availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.push(context, 
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title, 
          meals: filteredList,
        ) 
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController, 
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in grid
          childAspectRatio: 3 / 2, // Aspect Ratio
          crossAxisSpacing: 20, // Horizontal Spacing
          mainAxisSpacing: 20 // Vertical Spacing
        ),
        children: [
          for(final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      // Here we only want the padding to be animated
      builder: (context, child) => SlideTransition(
        position: Tween(
            begin: Offset(0, 0.3),
            end: Offset(0, 0),
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      )
    );
  }
}