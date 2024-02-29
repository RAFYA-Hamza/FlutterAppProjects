import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/widgets/list_meals.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({
    required this.title,
    required this.meals,
    required this.id,
    super.key,
  });
  final String title;
  final List<Meal> meals;
  final String id;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Meal> _newListOfMeals = [];

  @override
  void initState() {
    _traiteData(widget.meals);
    super.initState();
  }

  void _traiteData(List<Meal> meals) {
    for (var i = 0; i < meals.length; i++) {
      for (var element in meals[i].categories) {
        if (element == widget.id) {
          _newListOfMeals.add(meals[i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListMealsWidget(meals: _newListOfMeals),
    );
  }
}
