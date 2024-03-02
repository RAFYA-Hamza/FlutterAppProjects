import 'package:flutter/material.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/widgets/ingredients_steps_widget.dart';

class MealsDetailsScreen extends StatelessWidget {
  const MealsDetailsScreen({
    required this.category,
    required this.meals,
    super.key,
  });
  final Meal meals;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star),
          ),
        ],
        title: Text(
          meals.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    meals.imageUrl,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 230,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Ingredients",
                          style: TextStyle(
                            color: category.color,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ...meals.ingredients.map(
                          (ingredient) {
                            return IngredientStepWidget(text: ingredient);
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Steps",
                          style: TextStyle(
                            color: category.color,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ...meals.steps.map(
                          (step) {
                            return IngredientStepWidget(text: step);
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
