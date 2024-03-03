import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  late Widget activePage;
  late String activePageTitle;
  final List<Meal> _favoriteMeals = [];

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void toggleMealFavoriteStatus(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage("Meal is no longer a favorite.", meal);
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage("Marked as a favorite.", meal);
      });
    }
  }

  void _showInfoMessage(String message, Meal meal) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _favoriteMeals.remove(meal);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activePage = CategoriesScreen(
      onToggleFavorite: toggleMealFavoriteStatus,
    );
    activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your favorites';
      activePage = MealsScreen(
        onToggleFavorite: toggleMealFavoriteStatus,
        meals: _favoriteMeals,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
        ],
        onTap: selectPage,
      ),
    );
  }
}
