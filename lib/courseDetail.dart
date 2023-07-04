import 'package:flutter/material.dart';

class courseDetails extends StatefulWidget {
  const courseDetails({super.key});

  @override
  State<courseDetails> createState() => _courseDetailsState();
}

class _courseDetailsState extends State<courseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text("Course Name",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          Container(
            color: Colors.deepPurple[300],
            child: Icon(
              Icons.card_giftcard_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
          Container(
            color: Colors.deepPurpleAccent[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "XXXX",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
