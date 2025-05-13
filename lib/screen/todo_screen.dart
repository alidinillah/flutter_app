import 'package:flutter/material.dart';
import 'package:flutter_app/controller/todo_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoController controller;

  final List<Map<String, dynamic>> categories = [
    {'label': 'All'},
    {'label': 'To do'},
    {'label': 'In Progress'},
    {'label': 'Done'},
    {'label': 'Failed'},
    {'label': 'Archived'},
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.put(TodoController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Today's Tasks")),
        actions: [
          IconButton(
            onPressed: () => controller.fetchTodo(),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Obx(() {
        final dates = controller.dateList;
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final date = dates[index];
                  final isSelected =
                      controller.selectedDate.value.day == date.day &&
                          controller.selectedDate.value.month == date.month &&
                          controller.selectedDate.value.year == date.year;

                  return GestureDetector(
                    onTap: () => controller.setSelectedDate(date),
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepPurple : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.E().format(date),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat.d().format(date),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Colors.deepPurple
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          cat['label'],
                          style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.black87,
                            fontWeight: index == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                final todos = controller.todoList;
                if (todos.isEmpty) {
                  return const Center(child: Text("No tasks"));
                }

                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capitalizeEachWord(todo.title),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.alarm, size: 16,),
                                      SizedBox(width: 4),
                                      Text('10:00 AM', style: TextStyle(fontSize: 12, color: Colors.black54),),
                                    ],
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        color: todo.completed
                                            ? Colors.deepPurple.withOpacity(0.6)
                                            : Colors.blue.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(todo.completed ? 'Done' : 'To-do', style: TextStyle(fontSize: 10, color: Colors.white),)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  String capitalizeEachWord(String text) {
    return text
        .split(' ')
        .map((word) => word.isNotEmpty
        ? word[0].toUpperCase() + word.substring(1).toLowerCase()
        : '')
        .join(' ');
  }

}
