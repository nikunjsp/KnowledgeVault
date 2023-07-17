import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:knowledgevault/CourseDetailsPage.dart';
import 'models/Courses.dart';

class mycourses extends StatefulWidget {
  const mycourses({Key? key}) : super(key: key);

  @override
  State<mycourses> createState() => _mycoursesState();
}

class _mycoursesState extends State<mycourses> {

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
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My courses',
          style: TextStyle(
            fontFamily: 'RobotoMono', 
            color: Colors.black, 
            fontWeight: FontWeight.bold, 
            fontSize: 18
          ),
          ),
      ),
      body: Container(
  height: double.infinity,
  child: ListView(
    children: [
      
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 50, left: 25, right: 25),
        child: Column(
          children: [
          
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
      // body: ListView(
      //   children: [
      //     // const SizedBox(height: 20),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 25, right: 25),
      //           child: Column(
      //             children: [
      //             const SizedBox(height: 20),
      //               GridView.builder(
      //                 itemCount: courselist.length,
      //                 shrinkWrap: true,
      //                 physics: const NeverScrollableScrollPhysics(), 
      //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                   crossAxisCount: 2,
      //                   childAspectRatio: (MediaQuery.of(context).size.height) / (4 * 240),
      //                   mainAxisSpacing: 20,
      //                   crossAxisSpacing: 20 
      //                 ),
      //                 itemBuilder: (context,index) {
      //                   return InkWell(
      //                     onTap: () {},
      //                     child: Container(
      //                       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20),
      //                         color: const Color.fromRGBO(116, 85, 247, 0.1),
      //                       ),
      //                       child: Column(
      //                         children: [
      //                           Padding (padding: const EdgeInsets.all(20),
      //                           child: Image.asset('assets/icons/${courselist[index].picture}.jpg',
      //                                  width: 50,
      //                                  height: 50,
      //                           ),
      //                           ),
      //                           const SizedBox(height: 10,),
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Text( 
      //                             // textAlign : TextAlign.justify,
      //                             courselist[index].coursename,
      //                             style: const TextStyle(
      //                               fontFamily: 'RobotoMono',
      //                               fontWeight: FontWeight.w600,
      //                               fontSize: 16,
      //                               color: Colors.black,
      //                               ),
      //                             ),
      //                             Row(
      //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                               children: [
      //                               const Icon(
      //                               Icons.timer,
      //                               size : 16,
      //                               color: Color.fromRGBO(131, 136, 139, 1),
      //                             ),
      //                             Text(
      //                             textAlign : TextAlign.start,
      //                             courselist[index].duration, 
      //                             style: const TextStyle(
      //                               fontFamily: 'RobotoMono',
      //                               fontStyle: FontStyle.normal,
      //                               fontSize: 12,
      //                               fontWeight: FontWeight.w500,
      //                               color: Color.fromRGBO(131, 136, 139, 1),
      //                               ),
      //                             ),
      //                               ],
      //                             ),
      //                             ],
      //                           ),
                                
      //                           const SizedBox(height: 10),
      //                           Text(
      //                             textAlign : TextAlign.justify,
      //                             courselist[index].description, 
      //                             style: const TextStyle(
      //                               fontFamily: 'RobotoMono',
      //                               fontStyle: FontStyle.italic,
      //                               fontSize: 10,
      //                               color: Color.fromRGBO(131, 136, 139, 1),
      //                               ),
      //                             ),
      //                           // const SizedBox(height: 10), 
      //                         ],
      //                       ),
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //   ],
      // )
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