import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/tasktype.dart';
import 'package:todo_app/screens/add_new_task/add_new_task.dart';
import 'package:todo_app/screens/home/home_view/header_container.dart';
import 'package:todo_app/screens/home/home_view/todoitem.dart';
import 'package:todo_app/service/todo_service.dart';

import '../../model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// List<String> todos = ["Study Lesson", "Go to Gym", "Buy Groceries", "Call Mom"];
// List<String> completed = ["Go to Gym", "Call Mom"];
List<Task> todos = [
  Task(
    title: "Study Lesson",
    description: "Study Flutter",
    isCompleted: false,
    type: TaskType.note,
  ),
  Task(
    title: "Go to Gym",
    description: "Do some exercise",
    isCompleted: false,
    type: TaskType.calendar,
  ),
  Task(
    title: "Buy Groceries",
    description: "Buy some vegetables",
    isCompleted: false,
    type: TaskType.constent,
  ),
];
List<Task> completed = [
  Task(
    title: "Go to Gym",
    description: "Do some exercise",
    isCompleted: true,
    type: TaskType.calendar,
  ),
  Task(
    title: "Call Mom",
    description: "Ask about her health",
    isCompleted: true,
    type: TaskType.note,
  ),
];

class _HomePageState extends State<HomePage> {
  // Her bir görev için ayrı bir işaret durumu tutacak Map'ler
  Map<String, bool> todoStates = {};
  Map<String, bool> completedStates = {};

  @override
  void initState() {
    super.initState();
    // Başlangıçta tüm görevlerin işaret durumlarını false olarak ayarla
    for (var todo in todos) {
      todoStates[todo.toString()] = false;
    }
    for (var todo in completed) {
      completedStates[todo.toString()] = true; // Tamamlanmış görevler başlangıçta işaretli olarak ayarlandı
    }
  }

  void addNewTask(Task newTask) {
    setState(() {
      todos.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();

    return Scaffold(
      backgroundColor: HexColor(backgroundColor),
      body: Column(
        children: [
          //Headers
          const HeaderContainer(),
          // Yapılacaklar listesi
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: FutureBuilder(
                future: todoService.getUncompletedTodos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print(snapshot.data);
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return TodoItem(
                        task: snapshot.data![index],
                        title: '',
                      );
                    },
                  );
                },
              ),
            ),
          ),
          // Tamamlananlar listesi
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Completed ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: FutureBuilder(
                future: todoService.getcompletedTodos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print(snapshot.data);
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return TodoItem(
                        task: snapshot.data![index],
                        title: '',
                      );
                    },
                  );
                },
              ),
            ),
          ),
          // Yeni görev ekleme butonu
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddNewTask(
                        addNewTaska: ((newTask) => addNewTask(newTask)),
                      )));
            },
            child: const Text("Add Todo"),
          )
        ],
      ),
    );
  }
}
