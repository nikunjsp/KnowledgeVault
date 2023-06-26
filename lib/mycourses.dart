import 'package:flutter/material.dart';
import 'models/Courses.dart';

class mycourses extends StatefulWidget {
  const mycourses({Key? key}) : super(key: key);

  @override
  State<mycourses> createState() => _mycoursesState();
}

class _mycoursesState extends State<mycourses> {

  late final Courses course;

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

      body: ListView(
        children: [
          // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                  const SizedBox(height: 20),
                    GridView.builder(
                      itemCount: courselist.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), 
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (MediaQuery.of(context).size.height) / (4 * 240),
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20 
                      ),
                      itemBuilder: (context,index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(116, 85, 247, 0.1),
                            ),
                            child: Column(
                              children: [
                                Padding (padding: const EdgeInsets.all(20),
                                child: Image.asset('assets/icons/${courselist[index].picture}.jpg',
                                       width: 50,
                                       height: 50,
                                ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( 
                                  // textAlign : TextAlign.justify,
                                  courselist[index].coursename,
                                  style: const TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                    const Icon(
                                    Icons.timer,
                                    size : 16,
                                    color: Color.fromRGBO(131, 136, 139, 1),
                                  ),
                                  Text(
                                  textAlign : TextAlign.start,
                                  courselist[index].duration, 
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
                                
                                const SizedBox(height: 10),
                                Text(
                                  textAlign : TextAlign.justify,
                                  courselist[index].description, 
                                  style: const TextStyle(
                                    fontFamily: 'RobotoMono',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10,
                                    color: Color.fromRGBO(131, 136, 139, 1),
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
      )
    );
  }
}
