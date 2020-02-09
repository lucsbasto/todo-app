import 'package:moor_flutter/moor_flutter.dart';
import 'package:todo_app/models/todo.dart';

part 'database.g.dart';

@UseMoor(tables: [
  Todo
], queries: {
  '_getByType': 'SELECT * FROM todo WHERE todo_type = ?',
  '_completeTask': 'UPDATE todo SET is_finish = 1 WHERE id = ?',
  '_deleteTask': 'DELETE FROM todo WHERE id = ?'
})
class Database {}
