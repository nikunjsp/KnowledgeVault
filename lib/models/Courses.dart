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
  Courses(
      picture: 'node',
      coursename: 'Back-end using Node JS',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      duration: '1hrs'),
  Courses(
      picture: 'python',
      coursename: 'Basics of Python',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      duration: '1hrs 20mins'),
  Courses(
      picture: 'wordpress',
      coursename: 'Website with wordpress',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      duration: '1hrs 45mins'),
  Courses(
      picture: 'react',
      coursename: 'React for front-end',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      duration: '2hrs'),
];
