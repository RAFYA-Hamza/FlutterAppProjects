import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    required this.title,
    required this.meals,
    required this.id,
    super.key,
  });
  final String title;
  final List<Meal> meals;
  final String id;

  Widget contentMain(int index) {
    // Your code here
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(12),
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
            color: Colors.white.withOpacity(0.55),
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  meals[index].title,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("data"),
                    Text("data"),
                    Text("data"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          for (final element in meals[index].categories) {
            if (element == id) {
              print("return content");
              return contentMain(index);
            } else {
              print("retun null");
              break;
            }
          }
          return null;
        },
      ),
    );
  }
}
