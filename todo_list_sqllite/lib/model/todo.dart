class Todo {
  int? id;
  String? title;
  String? content;
  int? hasFinished;

  Todo({this.title, this.content, this.hasFinished, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'content' : content,
      'hasFinished' : hasFinished,
    };
  }
}