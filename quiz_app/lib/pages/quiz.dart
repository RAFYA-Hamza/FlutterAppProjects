import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/pages/questions_screen.dart';
import 'package:quiz_app/pages/start_screen.dart';
import 'package:quiz_app/pages/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  List<String> selectedAnswers = [];

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void callStartScreen() {
    resetSelectedAnswer();
    setState(() {
      activeScreen = StartScreen(switchScreen);
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(onSelectedAnswer: chooseAnswer);
    });
  }

  void resetSelectedAnswer() {
    selectedAnswers.clear();
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          chosenAnswer: selectedAnswers,
          startScreen: callStartScreen,
        );
        // selectedAnswers.clear();
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
