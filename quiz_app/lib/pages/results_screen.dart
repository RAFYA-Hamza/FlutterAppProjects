import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/widgets/results_widget.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.chosenAnswer,
    required this.startScreen,
    super.key,
  });
  final List<String> chosenAnswer;
  final void Function() startScreen;

  List<Map<String, Object>> get summaryData {
    List<Map<String, Object>> summary = [];
    int correctAnswerCounter = 0;

    for (var i = 0; i < chosenAnswer.length; i++) {
      if (chosenAnswer[i] == questions[i].answers[0]) {
        correctAnswerCounter++;
      }
      summary.add(
        {
          'question_index': i + 1,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswer[i],
          'correct_answer_counter': correctAnswerCounter,
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> lastData = summaryData[summaryData.length - 1];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          alignment: const Alignment(0.0, 0.8),
          height: 200,
          child: Text(
            "You answered ${lastData['correct_answer_counter']} out of ${questions.length} correctly!",
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 230, 165, 239),
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: summaryData.length,
            itemBuilder: (BuildContext context, int index) {
              final summaryItem = summaryData[index];
              return ResultsWidget(
                questionIndex: summaryItem['question_index'],
                question: summaryItem['question'],
                correctAnswer: summaryItem['correct_answer'],
                userAnswer: summaryItem['user_answer'],
              );
            },
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: TextButton(
            onPressed: () {
              startScreen();
            },
            style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 195, 94, 177)),
            ),
            child: Text(
              'Restart Quiz!',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(
          // width: double.infinity,
          height: 50,
        ),
      ],
    );
  }
}














// import 'package:flutter/material.dart';
// import 'package:quiz_app/data/questions.dart';
// import 'package:quiz_app/widgets/results_widget.dart';

// class ResultsScreen extends StatelessWidget {
//   const ResultsScreen({required this.chosenAnswer, super.key});
//   final List<String> chosenAnswer;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           color: Colors.amber,
//           width: double.infinity,
//           alignment: const Alignment(0.0, 0.8),
//           height: 200,
//           child: Text(
//               "You answered ${chosenAnswer.length} out of ${questions.length} correctly!"),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: questions.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ResultsWidget(
//                 questionText: questions[index].text,
//                 questionAnswer:
//                     questions[index].answers[0], // Assuming answers is a List
//                 selectedAnswer: chosenAnswer[index],
//               );
//             },
//           ),
//         ),
//         Container(
//           color: Colors.amber,
//           width: double.infinity,
//           height: 200,
//         ),
//       ],
//     );
//   }
// }
