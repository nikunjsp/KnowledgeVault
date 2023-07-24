import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(116, 85, 247, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''
Privacy Policy

Effective date: January 1, 2023

This Privacy Policy describes how our app collects, uses, and discloses personal information when you use our services. By using our app, you agree to the collection and use of information in accordance with this policy.

Information Collection and Use

We may collect certain personally identifiable information from you, including your name, email address, and phone number. This information is used solely for the purpose of providing and improving our services.

Data Security

We take reasonable measures to protect the security of your personal information. However, please be aware that no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.

Changes to This Privacy Policy

We may update our Privacy Policy from time to time. Any changes will be posted on this page. We advise you to review this Privacy Policy periodically for any changes.

Contact Us

If you have any questions about this Privacy Policy, please contact us.
''',
                  style:TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black,
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

