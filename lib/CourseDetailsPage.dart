import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetailsPage extends StatefulWidget {
  final Map<String, dynamic> arguments;

  CourseDetailsPage({required this.arguments});

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
    // Extract the necessary data from the arguments
    coursename = widget.arguments['coursename'];
    duration = widget.arguments['duration'];
    description = widget.arguments['description'];
    video = widget.arguments['video'];

    // Initialize the YouTube player controller with try-catch block
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
      // Handle the error gracefully, for example, you can show an error message to the user.
    }
  }

  void handleEnrollButton() {
    setState(() {
      isEnrolled = true;
    });
  }

  Widget buildVideoPlayer() {
    if (isEnrolled) {
      return YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor:
            Colors.amber, // You can change the progress indicator color here
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {
          // The controller is ready for method calls
          _youtubeController
              .play(); // Play the video when the controller is ready
        },
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height:
                MediaQuery.of(context).size.width * 0.5625, // 16:9 aspect ratio
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
    _youtubeController.dispose(); // Dispose the controller properly
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
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height *
                          paddingVertical *
                          0.5,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.04),
                      color: Color.fromRGBO(116, 85, 247, 1),
                    ),
                    child: Text(
                      "Courses Details",
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontStyle: FontStyle.normal,
                        fontSize:
                            MediaQuery.of(context).size.width * fontSize * 0.8,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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
