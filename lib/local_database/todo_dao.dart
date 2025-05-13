import 'package:floor/floor.dart';
import 'package:flutter_app/local_database/todo_entity.dart';

@dao
abstract class TodoDao{
  @Query('SELECT * FROM todos')
  Future<List<TodoEntity>> getAllTodos();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodos(List<TodoEntity> todos);

  @Query('DELETE * FROM todos')
  Future<void> clearTodos();
}