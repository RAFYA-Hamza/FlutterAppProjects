import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/widgets/results_widget.dart';

class ReslutsScreen extends StatefulWidget {
  const ReslutsScreen({required this.selectedAnswer, super.key});
  final List<String> selectedAnswer;

  @override
  State<ReslutsScreen> createState() => _ReslutsScreenState();
}

class _ReslutsScreenState extends State<ReslutsScreen> {
  var currectQuestion = questions[0];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.amber,
          width: double.infinity,
          alignment: const Alignment(0.0, 0.8),
          height: 200,
          child: Text(
              "You answered ${widget.selectedAnswer.length} out of ${questions.length} correctly!"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              return ResultsWidget(
                questionText: questions[index].text,
                questionAnswer:
                    questions[index].answers[0], // Assuming answers is a List
                selectedAnswer: widget.selectedAnswer[index],
              );
            },
          ),
        ),
        Container(
          color: Colors.amber,
          width: double.infinity,
          height: 200,
        ),
      ],
    );
  }
}
