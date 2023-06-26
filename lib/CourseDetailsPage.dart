import 'package:flutter/material.dart';
import 'widgets/CourseVideos.dart';

class CourseDetailsPage extends StatefulWidget {

  //const CourseDetailsPage(String picture, {Key? key}) : super(key: key);
  late String coursename;
  late String duration;
  CourseDetailsPage(this.coursename, this.duration);

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState(); 

}

class _CourseDetailsPageState extends State<CourseDetailsPage> {

  late final CourseVideos coursevideo;
  
  @override
  Widget build(BuildContext context) {

   return Scaffold(
    appBar: AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(widget.coursename),
    
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Row(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                          Icons.business_center,
                          size : 20,
                          color: Color.fromRGBO(116, 85, 247, 1),
                        ),
                        Text(
                          "1000", 
                          style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(116, 85, 247, 1),
                        ),
                       ),
                      ],
                   ),
                  ]
                ),
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(246, 245, 251, 1),
                  ),
                  child: const Icon(
                          Icons.play_circle_fill_rounded,
                          size : 50,
                          color: Color.fromRGBO(116, 85, 247, 1),
                  ),
                ),
                const SizedBox(height : 20),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text( 
                      "${widget.coursename} Complete Course",
                      style: const TextStyle(
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.timer,
                        size : 18,
                        color: Color.fromRGBO(131, 136, 139, 1),
                      ),
                      Text(
                        '${widget.duration}', 
                        style: const TextStyle(
                            fontFamily: 'RobotoMono',
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(131, 136, 139, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height : 5),

                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(131, 136, 139, 1),
                  ),
                ),

                const SizedBox(height: 25,),
                
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(116, 85, 247, 1),
                  ),
                  child: const Text(
                          "Courses Details",
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                ),

                const SizedBox(height: 20),

                ListView.builder(
                  itemCount: coursevideolist.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), 
                  itemBuilder: (BuildContext context, int index) {  
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: index == 0 ? const Color(0xFF674AEF) : const Color(0xFF674AEF).withOpacity(0.5) ,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      title: Text(
                        coursevideolist[index].name,
                        style: const TextStyle(
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        coursevideolist[index].duration,
                        style: const TextStyle(
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Color.fromRGBO(131, 136, 139, 1),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          bottomSheet: BottomSheet(
              onClosing: () {},
              backgroundColor: Colors.white,
              enableDrag: false,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF674AEF),
                      ),
                      
                      child: const Text(
                          'Enroll Course',
                          style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      );
                    },
            ),
        );
    }
}