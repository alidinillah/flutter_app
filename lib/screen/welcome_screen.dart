import 'package:flutter/material.dart';
import 'package:flutter_app/screen/todo_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          'Task Management & To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 8),
        Text(
          'This productive tool is designed to help you better manage your task project with conventionally',
          style: TextStyle(color: Colors.black12),
        ),
        ElevatedButton(onPressed: () {
          Get.to(TodoScreen());
        }, child: Text("Let's Start")),
      ]),
    );
  }
}
