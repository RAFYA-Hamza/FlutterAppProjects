import 'package:flutter/material.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({
    super.key,
    required this.questionIndex,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
  });

  final Object? questionIndex;
  final Object? question;
  final Object? correctAnswer;
  final Object? userAnswer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 195, 94, 177),
        maxRadius: 20,
        child: Text(
          questionIndex.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        question.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            correctAnswer.toString(),
            style: const TextStyle(color: Color.fromARGB(255, 195, 94, 177)),
          ),
          Text(
            userAnswer.toString(),
            style: const TextStyle(color: Color.fromARGB(255, 193, 165, 248)),
          ),
        ],
      ),
    );
  }
}











// import 'package:flutter/material.dart';

// class ResultsWidget extends StatelessWidget {
//   const ResultsWidget(
//       {required this.questionText,
//       required this.questionAnswer,
//       required this.selectedAnswer,
//       super.key});

//   final String questionText;
//   final String questionAnswer;
//   final String selectedAnswer;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: const Icon(Icons.ac_unit_rounded),
//       title: Text(
//         questionText,
//         style: const TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             questionAnswer,
//             style: const TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           Text(
//             selectedAnswer,
//             style: const TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
