import 'package:flutter/material.dart';
import 'package:knowledgevault/question_model.dart';
import 'package:knowledgevault/widgets/optionCard.dart';
import '../widgets/questionWidget.dart';
//import '../widgets/nextButton.dart';
//import 'question_model.dart';
import 'results.dart';

class quizquestions extends StatefulWidget {
  const quizquestions({super.key});

  @override
  State<quizquestions> createState() => _quizquestionsState();
}

class _quizquestionsState extends State<quizquestions> {
  final List<question> _questions = [
    question(
        id: '10',
        options: {'5': false, '30': false, '3': false, '4': true},
        title: "What is 2 + 2"),
    question(
        id: '20',
        options: {'10': false, '8': true, '3': false, '6': false},
        title: "What is 2 * 2 * 2"),
    question(
        id: '30',
        options: {'1': true, '3': false, '31': false, '4': false},
        title: "What is 2 / 2"),
    question(
        id: '40',
        options: {'5': false, '40': true, '3': false, '4': false},
        title: "What is 2 * 20"),
  ];

  int _questionIndex = 0;
  int totalScore = 0;
  bool answerWasSelect = false;
  bool endOfQuiz = false;

  void questionAnswered(bool answerScore) {
    setState(() {
      answerWasSelect = true;
      if (answerScore) {
        totalScore++;
      }
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelect = false;
    });

    if (_questionIndex >= _questions.length) {
      _questionIndex = 0;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => results(
                    score: totalScore,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHidth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.80,
              height: screenHidth * 0.22,
              child: questionWidget(
                  question: _questions[_questionIndex].title,
                  indexAction: _questionIndex,
                  totalQuestion: _questions.length),
            ),
            for (int i = 0; i < 4; i++)
              optionCard(
                answerText: _questions[_questionIndex].options.keys.toList()[i],
                answerColor: answerWasSelect
                    ? _questions[_questionIndex].options.values.toList()[i]
                        ? Colors.green
                        : Colors.red
                    : Colors.deepPurpleAccent,
                answerTap: () {
                  if (answerWasSelect) {
                    return;
                  }
                  questionAnswered(
                      _questions[_questionIndex].options.values.toList()[i]);
                },
              ),
            SizedBox(
              height: screenHidth * 0.18,
            ),
            Container(
              width: screenWidth * 0.85,
              child: ElevatedButton(
                onPressed: () {
                  if (!answerWasSelect) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Please Select Any Option",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )));
                    return;
                  }
                  nextQuestion();
                },
                child: Text(
                  endOfQuiz ? 'Check Results' : 'Next Question',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.8, 50),
                    primary: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            )
          ],
        ),
      ),

      //floatingActionButton: nextButton(
      //nextQuestion: nextQuestion,
      //),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
