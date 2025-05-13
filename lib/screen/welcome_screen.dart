import 'package:flutter/material.dart';
import 'package:flutter_app/screen/todo_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3222/3222691.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 24),
              const Text(
                'Task Management & To-Do List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'This productive tool is designed to help you better manage your task projects conveniently.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => TodoScreen());
                  },
                  child: const Text("Let's Start"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
