import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ProfilePage.dart';

class EditProfilePage extends StatefulWidget {
  final String initialFirstName;
  final String initialLastName;
  final String initialEmail;
  final String initialPhoneNumber;

  EditProfilePage({
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialEmail,
    required this.initialPhoneNumber,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('Users');

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialFirstName);
    _lastNameController = TextEditingController(text: widget.initialLastName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneController = TextEditingController(text: widget.initialPhoneNumber);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    String newFirstName = _firstNameController.text;
    String newLastName = _lastNameController.text;
    String newEmail = _emailController.text;
    String newPhoneNumber = _phoneController.text;

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String email = user.email ?? '';

      Map<String, dynamic> updatedUserData = {
        'firstName': newFirstName,
        'lastName': newLastName,
        'phoneNumber': newPhoneNumber,
        // Add other fields as needed
      };

      Query query = _userRef.orderByChild('email').equalTo(email);

      try {
        DataSnapshot snapshot =  (await query.once()).snapshot;

        Map<dynamic, dynamic>? userData = snapshot.value as Map<dynamic, dynamic>?;

        if (userData != null) {
          String key = userData.keys.first;
          await _userRef.child(key).update(updatedUserData);

          // Return to the previous screen with the updated profile information
          // ignore: use_build_context_synchronously
          Navigator.pop(context, {
            'firstName': newFirstName,
            'lastName': newLastName,
            'email': newEmail,
            'phone': newPhoneNumber,
          });
        }
      } catch (error) {
        // Handle error while saving changes
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to save changes.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(116, 85, 247, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(246, 245, 251, 1),
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
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
