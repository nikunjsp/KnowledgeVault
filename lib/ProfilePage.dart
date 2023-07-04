import 'package:flutter/material.dart';
import 'EditProfilePage.dart';
import 'ResetPasswordPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = 'User Name';
  String email = 'user@example.com';
  String mobileNumber = 'Mobile Number';

  void _editDetails() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialName: userName,
          initialEmail: email,
          initialPhoneNumber: mobileNumber,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        userName = result['name'];
        email = result['email'];
        mobileNumber = result['phone'];
      });
    }
  }

  void _editPassword() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(),
      ),
    );

    // Handle the result if needed
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Profile',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(116, 85, 247, 1),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            userName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            email,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            mobileNumber,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: _editDetails,
                child: Text('Edit Details'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(116, 85, 247, 0.1),
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: _editPassword,
                child: Text('Edit Password'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(116, 85, 247, 0.1),
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


}
