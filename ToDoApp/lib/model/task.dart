class Task {
  final int id;
  final String title;
  final String description;
  final String date;
  final int isDone;
  Task({this.id,this.isDone, this.title, this.description,this.date,});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date':date,
      'isDone':isDone,
      'title': title,
      'description': description,
    };
  }
}