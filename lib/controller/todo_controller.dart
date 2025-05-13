import 'package:flutter_app/models/todo.dart';
import 'package:flutter_app/services/todo_service.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var isLoading = true.obs;
  var todoList = <TodoModel>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    await TodoService.initDatabase();
    fetchTodo();
    super.onInit();
  }

  void fetchTodo() async {
    try {
      isLoading(true);
      var todo = await TodoService.fetchTodo();
      todoList.assignAll(todo);
    } finally {
      isLoading(false);
    }
  }
}
