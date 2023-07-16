import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:knowledgevault/CourseDetailsPage.dart';
import 'AppBar.dart';
import 'models/Courses.dart';
import 'myrewards.dart';
import 'marketplace.dart';
import 'mycourses.dart';
import 'faq.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Courses course;

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Bar(),
      body: ListView(
        children: [
          // Search bar
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: const TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(246, 245, 251, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search your topic',
                hintStyle: TextStyle(
                    color: Color.fromRGBO(131, 136, 139, 1), fontSize: 12),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          //Courses
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 50, left: 25, right: 25),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Courses",
                        style: TextStyle(
                            fontFamily: 'RobotoMono',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  itemCount: courselist.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio:
                          (MediaQuery.of(context).size.height) / (4 * 130),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailsPage(
                                  courselist[index].coursename,
                                  courselist[index].duration),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(116, 85, 247, 0.1),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                              child: Image.asset(
                                'assets/icons/${courselist[index].picture}.jpg',
                                width: 300,
                                height: 100,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                  child: Text(
                                    // textAlign : TextAlign.justify,
                                    courselist[index].coursename,
                                    style: const TextStyle(
                                      fontFamily: 'RobotoMono',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      size: 16,
                                      color: Color.fromRGBO(131, 136, 139, 1),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        courselist[index].duration,
                                        style: const TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(131, 136, 139, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Text(
                                textAlign: TextAlign.justify,
                                courselist[index].description,
                                style: const TextStyle(
                                  fontFamily: 'RobotoMono',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                  color: Color.fromRGBO(131, 136, 139, 1),
                                ),
                              ),
                            ),
                            // const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        showUnselectedLabels: true,
        selectedItemColor: const Color.fromRGBO(116, 85, 247, 1),
        selectedFontSize: 12,
        unselectedItemColor: const Color.fromRGBO(131, 136, 139, 1),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_sharp), label: 'My Rewards'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_outlined), label: 'Marketplace'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: 'My Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_outlined), label: 'FAQs'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const myrewards()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const marketplace()),
            );
          } else if (index == 2) {
            // No action needed
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const mycourses()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => faq()),
            );
          }
        },
      ),
    );
  }
}
