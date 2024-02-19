import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/widgets/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({required this.onSelectedAnswer, super.key});
  final void Function(String answer) onSelectedAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  var currentQuestion = questions[0];

  void updateQuestions(String answer) {
    widget.onSelectedAnswer(answer);

    currentQuestionIndex++;
    if (currentQuestionIndex < 6) {
      setState(() {
        currentQuestion = questions[currentQuestionIndex];
      });
    }
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQuestion.text,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 126, 78, 169),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // the column widget return a list of widget, and the map convert
          // the list of string to a list of Widget. So in this case we have
          // an error, [Text(), SiedBox(), [AnswerButton()]], to fix that
          // we will add three dote to find [Text(), SiedBox(), AnswerButton()]
          ...currentQuestion.shuffledAnswers.map(
            (answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  updateQuestions(answer);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
