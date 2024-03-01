import 'package:flutter/material.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/meal_details_screen.dart';

class ListMealsWidget extends StatelessWidget {
  const ListMealsWidget({
    required this.category,
    required this.meals,
    super.key,
  });
  final List<Meal> meals;
  final Category category;

  Widget listOfParameters(Widget? leading, String title) {
    return Row(
      children: [
        leading!,
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MealsDetailsScreen(
                      meals: meals[index],
                      category: category,
                    );
                  },
                ),
              );
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.55),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        meals[index].imageUrl,
                      ),
                    ),
                  ),
                  height: 200,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.55),
                  ),
                  height: 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        meals[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listOfParameters(
                            const Icon(Icons.alarm),
                            "${meals[index].duration} min",
                          ),
                          listOfParameters(
                            const Icon(Icons.shopping_bag),
                            meals[index].complexity.name.toString(),
                          ),
                          listOfParameters(
                            const Icon(Icons.monetization_on_outlined),
                            meals[index].affordability.name.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
