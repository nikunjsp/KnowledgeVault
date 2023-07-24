import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import  'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'myrewards.dart';
import 'marketplace.dart';
import 'mycourses.dart';
import 'HomePage.dart';

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}
class faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<faq> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search questions...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance.ref().child('faqs'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

                  if (data != null) {
                    final faq = FAQ(
                      question: data['question'] as String,
                      answer: data['answer'] as String,
                    );

                    if (_searchQuery.isEmpty ||
                        faq.question.toLowerCase().contains(_searchQuery.toLowerCase())) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(116, 85, 247, 0.1),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      faq.question,
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left, // Align the question text to the left
                    ),
                    children: [
                      Align(
                        alignment: Alignment.topLeft, // Align the answer text to the left
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Text(
                            faq.answer,
                            textAlign: TextAlign.left, // Align the answer text to the left
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              color: Color.fromRGBO(131, 136, 139, 1),
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

                  // Return an empty container if data is null, not in the expected format, or not matching the search query
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        showUnselectedLabels: true,
        selectedItemColor: Color.fromRGBO(116, 85, 247, 1),
        selectedFontSize: 12,
        unselectedItemColor: Color.fromRGBO(131, 136, 139, 1),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_sharp),
            label: 'My Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
            label: 'FAQs',
          ),
        ],
        currentIndex: 4,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => myrewards()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => marketplace()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => mycourses()),
            );
          }
        },
      ),
    );
  }
}
