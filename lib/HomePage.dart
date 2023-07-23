import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowledgevault/CourseDetailsPage.dart';
import 'CoursePlayer.dart';
import 'AppBar.dart';
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
  int _selectedIndex = 2;

  final DatabaseReference _courseRef =
      FirebaseDatabase.instance.ref().child('Course');
  List<Courses> courselist = [];

  final DatabaseReference _userRef =
      FirebaseDatabase.instance.ref().child('Users');
  List<dynamic> enrolledCourse = [];
  bool isEnrolled = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('Users');

        Query query = userRef.orderByChild('email').equalTo(user.email);

        DataSnapshot snapshot2 = (await query.once()).snapshot;
        Map<dynamic, dynamic>? userData =
            snapshot2.value as Map<dynamic, dynamic>?;

        if (userData != null) {
          Map<dynamic, dynamic> userRecord = userData.values.first;
          List<dynamic> userCourses = userRecord['userCourses'];
          DatabaseEvent event = await _courseRef.once();
          DataSnapshot snapshot = event.snapshot;

          if (snapshot.value != null &&
              snapshot.value is Map<dynamic, dynamic>) {
            Map<dynamic, dynamic> dataList =
                snapshot.value as Map<dynamic, dynamic>;
            List<Courses> fetchedcourses = [];

            dataList.forEach((key, value) {
              Courses course = Courses.fromMap(value);
              fetchedcourses.add(course);
            });

            setState(() {
              courselist = fetchedcourses;
              enrolledCourse = userCourses;
            });
          }
        }
      }
    } catch (error) {
      print('Error fetching courses data: $error');
    }
  }

  void checkEnroll(int index) {
    setState(() {
      isEnrolled = enrolledCourse.contains(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Bar(),
      body: Container(
        height: double.infinity,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 50, left: 25, right: 25),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Courses",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: courselist.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          checkEnroll(index);
                          print(isEnrolled);
                          isEnrolled
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CoursePlayer(arguments: {
                                      'coursename':
                                          courselist[index].coursename ?? '',
                                      'duration':
                                          courselist[index].duration ?? '',
                                      'description':
                                          courselist[index].description ?? '',
                                      'thumbnail':
                                          courselist[index].thumbnail ?? '',
                                      'video': courselist[index].video ?? '',
                                    }, enrolledCourseKey: index),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CourseDetailsPage(arguments: {
                                      'coursename':
                                          courselist[index].coursename ?? '',
                                      'duration':
                                          courselist[index].duration ?? '',
                                      'description':
                                          courselist[index].description ?? '',
                                      'thumbnail':
                                          courselist[index].thumbnail ?? '',
                                      'video': courselist[index].video ?? '',
                                    }, enrolledCourseKey: index),
                                  ),
                                );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(116, 85, 247, 0.1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            courselist[index].thumbnail ?? '',
                                            fit: BoxFit.cover,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    courselist[index]
                                                            .coursename ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontFamily: 'RobotoMono',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timer,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      courselist[index]
                                                              .duration ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'RobotoMono',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            131, 136, 139, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              courselist[index].description ??
                                                  '',
                                              style: const TextStyle(
                                                fontFamily: 'RobotoMono',
                                                fontStyle: FontStyle.normal,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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

class Courses {
  String? thumbnail;
  String? coursename;
  String? description;
  String? duration;
  String? video;

  Courses({
    this.thumbnail,
    this.coursename,
    this.description,
    this.duration,
    this.video,
  });

  factory Courses.fromMap(Map<dynamic, dynamic> map) {
    return Courses(
      coursename: map['coursename'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      video: map['video'] ?? '',
    );
  }
}
