class Courses {

  String picture;
  String coursename;
  String description;
  String duration;

  Courses({
    required this.picture,
    required this.coursename,
    required this.description,
    required this.duration,
  });
}

List<Courses> courselist = [

  Courses(picture: 'assets/icons/laptop.jpg', coursename: 'Development', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', duration: '1hrs'),
  Courses(picture: 'assets/icons/accounting.jpg', coursename: 'Account', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', duration: '1hrs 20mins'),
  Courses(picture: 'assets/icons/design.jpg', coursename: 'Design', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', duration: '1hrs 45mins'),
  Courses(picture: 'assets/icons/laptop.jpg', coursename: 'Coding', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', duration: '2hrs'),

];