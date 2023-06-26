import 'package:flutter/material.dart';
import 'package:knowledgevault/quizquestions.dart';

class quizpage extends StatefulWidget {
  const quizpage({super.key});

  @override
  State<quizpage> createState() => _quizpageState();
}

class _quizpageState extends State<quizpage> {
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        title: Text(
          "Quiz",
          style: TextStyle(
              color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenheight * 0.1,
                  left: screenwidth * 0.1,
                  right: screenwidth * 0.1,
                  bottom: screenheight * 0.1),
              child: Text(
                "The quiz is based on what you have learned in the course. The quiz contains 10 questions and with the each correct answer you will get 10 coins. The questions are in the multiple choice format. Chose only one option from the four options. You will be able to see the marks after the completion of your quiz.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'San Francisco',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const quizquestions()),
                    );
                  },
                  child: const Text('Take Quiz'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
