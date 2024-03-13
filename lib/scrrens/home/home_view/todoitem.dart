// todo_item.dart
import 'package:flutter/material.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/model/task.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.StringisCompleted ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.task.type == TaskType.note
                ? Image.asset("assets/images/category_1.png")
                : widget.task.type == TaskType.constent
                    ? Image.asset("assets/images/category_3.png")
                    : Image.asset("assets/images/category_2.png"),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        decoration: widget.task.StringisCompleted ? TextDecoration.lineThrough : TextDecoration.none),
                  ),
                  Text(
                    widget.task.description,
                    style: TextStyle(fontSize: 15, decoration: widget.task.StringisCompleted ? TextDecoration.lineThrough : TextDecoration.none),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (val) {
                setState(() {
                  widget.task.StringisCompleted = !widget.task.StringisCompleted;
                  isChecked = val!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
