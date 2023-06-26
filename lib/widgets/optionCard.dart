import 'package:flutter/material.dart';

class optionCard extends StatelessWidget {
  optionCard(
      {super.key,
      required this.answerText,
      required this.answerColor,
      required this.answerTap}) {
    this.answerText;
    this.answerColor;
    this.answerTap;
  }
  final String answerText;
  final Color answerColor;
  final VoidCallback answerTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 4.0, left: 20, right: 20, bottom: 4),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: answerColor,
          child: ListTile(
            title: Text(
              answerText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
