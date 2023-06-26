class question {
  final String id;
  final String title;
  final Map<String, bool> options;

  question({required this.id, required this.options, required this.title});

  @override
  String toString() {
    return 'question(id :$id, title:$title,options:$options)';
  }
}
