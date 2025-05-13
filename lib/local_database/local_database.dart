import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_app/local_database/todo_dao.dart';
import 'package:flutter_app/local_database/todo_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'local_database.g.dart';

@Database(version: 1, entities: [TodoEntity])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}