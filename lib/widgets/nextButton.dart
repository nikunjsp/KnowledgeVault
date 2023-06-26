import 'package:flutter/material.dart';

class nextButton extends StatelessWidget {
  const nextButton({super.key, required this.nextQuestion});

  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context) {
    final Screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.deepPurpleAccent),
        width: Screenwidth * 0.90,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Next Question',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
