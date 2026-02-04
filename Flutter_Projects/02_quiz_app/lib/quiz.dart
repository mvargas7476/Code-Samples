import 'package:flutter/material.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key,});

  @override
  State<Quiz> createState() {
   return _QuizState(); 
  }
}

class _QuizState extends State<Quiz> {
  // Here we are casting active screen to be a generic Widget type that will be used later
  // Widget? activeScreen;
  var activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  // Init gets run after everything has been set and run and created. so After everything runs, then we set the loading to the start
  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  void switchScreen() {
    setState(() {
      // This first commented out section is there in case we wanted to use the initState
      // activeScreen = const QuestionsScreen();
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (questions.length == selectedAnswers.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 74, 22, 164), 
                const Color.fromARGB(255, 121, 72, 207)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          ),
          // If active screen start screen we show start, else if resul, we show results, else we show questions
          child: (activeScreen == 'start-screen') 
            ? StartScreen(switchScreen) 
            : (activeScreen == 'results-screen') ? ResultsScreen(chosenAnswers: selectedAnswers, onRestart: restartQuiz,) : QuestionsScreen(onSelectAnswer: chooseAnswer),
        )
      )
    );
  }
}