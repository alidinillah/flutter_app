import 'package:flutter/material.dart';
import 'package:flutter_app/screen/welcome_screen.dart';
import 'package:flutter_app/services/todo_service.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TodoService.simulateOffline = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: WelcomeScreen(),
    );
  }
}
