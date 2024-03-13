// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_app/constants/tasktype.dart';

class Task {
  String title;
  String description;
  bool StringisCompleted;
  TaskType type;
  Task({
    required this.title,
    required this.description,
    required this.StringisCompleted,
    required this.type,
  });
}
