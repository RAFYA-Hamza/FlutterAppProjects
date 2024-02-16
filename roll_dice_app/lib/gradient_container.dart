import 'package:flutter/material.dart';
import 'package:roll_dice_app/dice_controller.dart';

class GredientContainer extends StatelessWidget {
  const GredientContainer({super.key, required this.colors});

  final List<Color> colors;
  GredientContainer.purple({super.key})
      : colors = [
          Colors.deepPurple,
          Colors.indigo,
        ];

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
