import 'package:frontend/Constants/api.dart';

class Task {
  int id;
  String title;
  String desc;
  bool isDone;
  // String date;
  Task({
    required this.id,
    required this.title,
    required this.desc,
    required this.isDone, required String email,
     // this.date,
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      isDone: json['isDone'], email: globalemail,
    );
  }
}
