import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class Task {
  final String task;
  final bool isDone;
  const Task(this.task, this.isDone);
}

final List<Task> _taskList = [
  new Task("Call tom about appointment", false),
  new Task("Edit API documentation", false),
  new Task("Fix on boarding experience", false),
  new Task("Have coffee with Sam", true),
  new Task("Clean my bedroom", true),
];

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        return _taskList[index].isDone
            ? _tasksComplete(_taskList[index].task)
            : _tasksUncomplete(_taskList[index].task);
      },
    );
  }

  Widget _tasksUncomplete(String task) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 24.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.radio_button_unchecked,
            color: Theme.of(context).accentColor,
            size: 30,
          ),
          SizedBox(
            width: 24,
          ),
          Text(task),
        ],
      ),
    );
  }

  Widget _tasksComplete(String task) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60fdfdfd)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 24.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).accentColor,
              size: 30,
            ),
            SizedBox(
              width: 24,
            ),
            Text(task),
          ],
        ),
      ),
    );
  }
}
