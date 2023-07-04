class CourseVideos {

  String name;
  String duration;

  CourseVideos({
    required this.name,
    required this.duration,
  });
}

List<CourseVideos> coursevideolist = [

  CourseVideos(name: 'Introduction', duration: '5mins'),
  CourseVideos(name: 'Installing', duration: '15mins'),
  CourseVideos(name: 'Setup', duration: '30mins'),
  CourseVideos(name: 'Creating', duration: '1hrs 20mins'),
  CourseVideos(name: 'Advanced', duration: '2hrs'),

];