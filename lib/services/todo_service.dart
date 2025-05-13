import 'dart:convert';

import 'package:flutter_app/local_database/local_database.dart';
import 'package:flutter_app/local_database/todo_entity.dart';
import 'package:flutter_app/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoService {
  static bool simulateOffline = false;

  static late AppDatabase database;

  static Future<void> initDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('todo_database.db').build();
  }
  static Future<List<TodoModel>> fetchTodo() async {
    final todoDao = database.todoDao;

    if (simulateOffline) {
      final localTodos = await todoDao.getAllTodos();
      return localTodos.map((e) => TodoModel(id: e.id, title: e.title, completed: e.completed)).toList();
    }
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final todos = jsonData.map((e) => TodoModel.fromJson(e)).toList();

      await todoDao.clearTodos();
      await todoDao.insertTodos(todos.map((e) => TodoEntity(id: e.id, title: e.title, completed: e.completed)).toList());

      return todos;
    } else {
      throw Exception("Failed to load todo");
    }
  }
}