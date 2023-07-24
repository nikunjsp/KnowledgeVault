import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About Us',
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
            Text(
              'About Us',
              style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    color: Colors.black,
                                    ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to KnowledgeVault!',
              style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black,
                                    ),
            ),
            SizedBox(height: 10),
            Text(
              'KnowledgeVault is a platform that aims to provide valuable knowledge and resources to users. Our mission is to empower individuals to learn and grow in their areas of interest.',
              style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black,
                                    ),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    color: Colors.black,
                                    ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: info@knowledgevault.com',
              style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                    ),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: +1 123-456-7890',
              style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                    ),
            ),
          ],
        ),
      ),
    );
  }
}

