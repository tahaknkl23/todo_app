// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_app/constants/tasktype.dart';

class Task {
  String title;
  String description;
  bool isCompleted;
  TaskType type;
  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.type,
  });
}
