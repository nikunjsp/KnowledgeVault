class Courses {
  
  String thumbnail, coursename, description, duration;

  Courses({
    required this.thumbnail,
    required this.coursename,
    required this.description,
    required this.duration,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      thumbnail: json['thumbnail'],
      coursename: json['coursename'],
      description: json['description'],
      duration: json['duration'],
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