import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'EditProfilePage.dart';
import 'ResetPasswordPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = 'First Name';
  String lastName = 'Last Name';
  String email = 'user@example.com';
  String mobileNumber = 'Mobile Number';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

void _fetchUserData() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child('Users');

    Query query = userRef.orderByChild('email').equalTo(user.email);
    DataSnapshot snapshot = (await query.once()).snapshot;

    Map<dynamic, dynamic>? userData =
        snapshot.value as Map<dynamic, dynamic>?;

    if (userData != null) {
      Map<dynamic, dynamic> userRecord = userData.values.first;

      setState(() {
        firstName = userRecord['firstName'];
        lastName = userRecord['lastName'];
        email = userRecord['email'];
        mobileNumber = userRecord['phoneNumber'];
      });
    }
  }
}

  void _editDetails() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialFirstName: firstName,
          initialLastName: lastName,
          initialEmail: email,
          initialPhoneNumber: mobileNumber,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        firstName = result['firstName'];
        lastName = result['lastName'];
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
              firstName + " " +lastName, 
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(246, 245, 251, 1),
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Edit Details',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(246, 245, 251, 1),
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Edit Password',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
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
