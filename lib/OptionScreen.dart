import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'SignUpScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OptionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Image.asset('assets/icons/splash_screen.png'),
            ),

            Container(
                margin: EdgeInsets.only(top: 190),
                width: 300,
                height: 50,

                child: ElevatedButton(
                  onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom( primary: Colors.deepPurpleAccent, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),)),
              child: Text('Log In', style: TextStyle(fontSize: 20, color: Colors.white),),
            )),
            SizedBox(height: 20),
            Container(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom( primary: Colors.white, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),)),
              child: Text('Sign Up', style: TextStyle( fontSize: 20, color: Colors.black ),),
            )),
          ],
        ),
      ),
    );
  }
}
