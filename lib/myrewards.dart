import 'package:flutter/material.dart';

class myrewards extends StatefulWidget {
    const myrewards({Key? key}) : super(key: key);
    
  @override
  State<myrewards> createState() => _myrewardsState();
}

class _myrewardsState extends State<myrewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center
      (
        child: Text("My Rewards"),
      ),
    );
  }
}
