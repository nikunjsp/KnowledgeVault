import 'package:flutter/material.dart';
import 'HomePage.dart';

class results extends StatelessWidget {
  const results({super.key, required this.score});

  final int score;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    int earnedPoint = score * 10;
    int percentage = ((score / 10) * 100).round();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
      ),
      body: Center(
          child: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight * 0.20,
              child: Text(
                "Results",
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                child: Text(
                  "You Scored",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.15,
              child: Text(
                '$percentage%',
                style: TextStyle(
                    fontSize: 75,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                child: Text(
                  'Congratulations',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25),
                ),
              ),
            ),
            Container(
              child: Text(
                'You have earned $earnedPoint points',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black54),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
