import 'package:floor/floor.dart';

@Entity(tableName: 'todo')
class TodoEntity{
  @primaryKey
  final int id;
  final String title;
  final bool completed;
  TodoEntity({required this.id, required this.title, required this.completed});
}