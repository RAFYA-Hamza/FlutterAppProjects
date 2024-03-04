import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/ingredient_step_widget.dart';

class MealsDetailsScreen extends ConsumerWidget {
  const MealsDetailsScreen({
    required this.meal,
    super.key,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // we need to pass the WidegtRef

    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final wasAdd = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(
                      meal); // we are add notifier to acces the class that define it in our provider

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(
                      wasAdd ? "Meal marked as a favorite." : "Meal removed."),
                  action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        ref
                            .read(favoriteMealsProvider.notifier)
                            .toggleMealFavoriteStatus(meal);
                      }),
                ),
              );
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
        title: Text(
          meal.title,
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
                    meal.imageUrl,
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
                        const Text(
                          "Ingredients",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ...meal.ingredients.map(
                          (ingredient) {
                            return IngredientStepWidget(text: ingredient);
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Steps",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ...meal.steps.map(
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
