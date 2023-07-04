import 'package:flutter/material.dart';

class questionWidget extends StatelessWidget {
  const questionWidget(
      {super.key,
      required this.question,
      required this.indexAction,
      required this.totalQuestion});

  final question;
  final int indexAction;
  final int totalQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Text(
                  '${indexAction + 1}. $question',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
