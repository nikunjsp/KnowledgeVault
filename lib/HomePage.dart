import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:knowledgevault/CourseDetailsPage.dart';
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

  final DatabaseReference _courseRef = FirebaseDatabase.instance.ref().child('Course');
List<Courses> courselist = [];

@override
void initState() {
  super.initState();
  fetchData();
}

void fetchData() async {
  try {
    DatabaseEvent event = await _courseRef.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null && snapshot.value is List<dynamic>) {
      List<dynamic> dataList = snapshot.value as List<dynamic>;
      print('Retrieved data: $dataList');

      List<Courses> fetchedcourses = [];
      for (dynamic data in dataList) {
        if (data is Map<String, dynamic>) {
          Courses course = Courses.fromJson(data);
          fetchedcourses.add(course);
        }
      }

      setState(() {
        courselist = fetchedcourses;
      });
    } else {
      print('Invalid data format: ${snapshot.value}');
    }
  } catch (error) {
    print('Error fetching courses data: $error');
  }
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
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 50, left: 25, right: 25),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailsPage(
                          courselist[index].coursename ?? '',
                          courselist[index].duration ?? '',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  courselist[index].thumbnail ?? '',
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                      child: Text(
                                        courselist[index].coursename ?? '',
                                        style: const TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                                          courselist[index].duration ?? '',
                                          style: const TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(131, 136, 139, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                courselist[index].description ?? '',
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
                            const SizedBox(height: 10), // Adjust the value for desired spacing
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

class Courses {
  String? thumbnail;
  String? coursename;
  String? description;
  String? duration;

  Courses({
    this.thumbnail,
    this.coursename,
    this.description,
    this.duration,
  });

  factory Courses.fromJson(Map<dynamic, dynamic> json) {
    return Courses(
      coursename: json['coursename'],
      description: json['description'],
      duration: json['duration'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String,dynamic> toJson() {

    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['coursename'] = this.coursename;
    data['description'] = this.description;
    data['duration'] = this.duration;

    return data;
  }
}
