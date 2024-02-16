import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/widgets/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestion = questions[0];
  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentQuestion.text),
          const SizedBox(height: 30),
          // the column widget return a list of widget, and the map convert
          // the list of string to a list of Widget. So in this case we have
          // an error, [Text(), SiedBox(), [AnswerButton()]], to fix that
          // we will add three dote to find [Text(), SiedBox(), AnswerButton()]
          ...currentQuestion.answers.map(
            (answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
