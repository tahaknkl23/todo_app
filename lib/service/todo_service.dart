import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/model/todo.dart';

class TodoService {
  final String url = "https://dummyjson.com/todos";

  Future<List<Todo>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dynamic responseBody = jsonDecode(response.body);
      final List<dynamic> todos = responseBody['todos'];
      List<Todo> uncompletedTodos = [];

      for (var item in todos) {
        Todo todo = Todo.fromJson(item);
        if (todo.completed == false) {
          uncompletedTodos.add(todo);
        }
      }

      return uncompletedTodos;
    } else {
      throw 'Failed to load uncompleted todos';
    }
  }

  Future<List<Todo>> getcompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dynamic responseBody = jsonDecode(response.body);
      final List<dynamic> todos = responseBody['todos'];
      List<Todo> uncompletedTodos = [];

      for (var item in todos) {
        Todo todo = Todo.fromJson(item);
        if (todo.completed == true) {
          uncompletedTodos.add(todo);
        }
      }

      return uncompletedTodos;
    } else {
      throw 'Failed to load uncompleted todos';
    }
  }
}
