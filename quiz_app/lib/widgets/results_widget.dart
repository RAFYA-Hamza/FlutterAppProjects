import 'package:flutter/material.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget(
      {required this.questionText,
      required this.questionAnswer,
      required this.selectedAnswer,
      super.key});

  final String questionText;
  final String questionAnswer;
  final String selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.ac_unit_rounded),
      title: Text(
        questionText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionAnswer,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            selectedAnswer,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
