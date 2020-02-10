import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:todo_app/models/todo.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
part 'database.g.dart';

@UseMoor(tables: [
  Todo
], queries: {
  '_getByType':
      'SELECT * FROM todo WHERE todo_type = ? ORDER BY is_finish, date, time',
  '_completeTask': 'UPDATE todo SET is_finish = 1 WHERE id = ?',
  '_deleteTask': 'DELETE FROM todo WHERE id = ?'
})
class Database extends _$Database with ChangeNotifier {
  // we tell the database where to store the data with this constructor
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'todo_file.sqlite'));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  // Stream<List<TodoData>> getTodoByType(int type) => _watchGetByType(type);
  Stream<List<TodoData>> getTodoOrderBy(int type) {
    if (type == 0) {
      return (select(todo)
            ..where((t) => t.todoType.equals(type))
            ..orderBy([(t) => OrderingTerm(expression: t.isFinish)]))
          .watch();
    } else {
      return (select(todo)
            ..where((t) => t.todoType.equals(type))
            ..orderBy([(t) => OrderingTerm(expression: t.time)]))
          .watch();
    }
  }

  Future insertTodoEntries(TodoData entry) {
    return into(todo).insert(entry);
  }

  Future deleteTodoEntries(int id) {
    return _deleteTask(id);
  }

  Future completeTodoEntries(int id) {
    return _completeTask(id);
  }
}
