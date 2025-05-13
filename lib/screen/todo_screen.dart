import 'package:flutter/material.dart';
import 'package:flutter_app/controller/todo_controller.dart';
import 'package:get/get.dart';

class TodoScreen extends StatelessWidget {
  final controller = Get.put(TodoController());
  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Today's Tasks")),
        actions: [
          IconButton(
              onPressed: () {
                controller.fetchTodo();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
            itemCount: controller.todoList.length,
            itemBuilder: (context, index) {
              final todo = controller.todoList[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('10:00 AM'),
                            Text(todo.completed ? 'Done' : 'To-do'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
