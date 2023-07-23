import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:knowledgevault/mycourses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CourseDetailsPage extends StatefulWidget {
  final Map<String, dynamic> arguments;
  late final int enrolledCourseKey;

  CourseDetailsPage({required this.arguments, required this.enrolledCourseKey});

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  final double fontSize = 0.04;
  final double paddingVertical = 0.03;
  final double paddingHorizontal = 0.05;
  late String coursename;
  late String duration;
  late String description;
  late String video;

  bool isEnrolled = false;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    coursename = widget.arguments['coursename'];
    duration = widget.arguments['duration'];
    description = widget.arguments['description'];
    video = widget.arguments['video'];

    try {
      _youtubeController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(video)!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          disableDragSeek: true,
        ),
      );
    } catch (e) {
      print('Error initializing YouTube player: $e');
    }
  }

  void updateUserCourses(enrolledCourseKey) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('Users');
      Query query = userRef.orderByChild('email').equalTo(user.email);

      DataSnapshot snapshot = (await query.once()).snapshot;
      Map<dynamic, dynamic>? userData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (userData != null) {
        String userId = userData.keys.first;
        Map<dynamic, dynamic> userRecord = userData.values.first;

        List<dynamic> userCourses = List.from(userRecord['userCourses'] ?? []);
        var courseKey = widget.enrolledCourseKey;

        if (!userCourses.contains(enrolledCourseKey)) {
          userCourses.add(enrolledCourseKey);
        }

        userRef.child(userId).update({
          'userCourses': userCourses,
        }).then((_) {
          setState(() {
            isEnrolled = true;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const mycourses(),
            ),
          );
        }).catchError((error) {
          print('Failed to update courses: $error');
        });
      }
    }
  }

  void handleEnrollButton() {
    updateUserCourses(widget.enrolledCourseKey);
  }

  Widget buildVideoPlayer() {
    if (isEnrolled) {
      return YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {
          _youtubeController.play();
        },
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.5625,
            color: Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.lock),
            color: Colors.white,
            iconSize: 50,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Enrollment Status'),
                    content: Text('You should enroll in this course.'),
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
            },
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          coursename,
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.width * fontSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVideoPlayer(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * paddingVertical,
                horizontal:
                    MediaQuery.of(context).size.width * paddingHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height * paddingVertical),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height *
                          paddingVertical *
                          0.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                    ),
                    child: Text(
                      "   Course Details",
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontStyle: FontStyle.normal,
                        fontSize:
                            MediaQuery.of(context).size.width * fontSize * 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          paddingVertical *
                          1.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  coursename,
                                  style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            fontSize *
                                            1.2,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.1),
                                Text(
                                  duration,
                                  style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            fontSize *
                                            0.8,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(131, 136, 139, 1),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.width *
                                    fontSize *
                                    0.3),
                            Text(
                              description,
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontStyle: FontStyle.normal,
                                fontSize: MediaQuery.of(context).size.width *
                                    fontSize *
                                    0.6,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(131, 136, 139, 1),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    paddingVertical *
                                    1.5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isEnrolled
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical:
                    MediaQuery.of(context).size.height * paddingVertical * 0.5,
                horizontal:
                    MediaQuery.of(context).size.width * paddingHorizontal * 0.5,
              ),
              child: GestureDetector(
                onTap: handleEnrollButton,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * fontSize * 0.5),
                    color: Color(0xFF674AEF),
                  ),
                  child: Text(
                    'Enroll Course',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize:
                          MediaQuery.of(context).size.width * fontSize * 0.8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
