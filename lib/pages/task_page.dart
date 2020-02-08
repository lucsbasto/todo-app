import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_button.dart';

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
            ? _tasksComplete(_taskList[index])
            : _tasksUncomplete(_taskList[index]);
      },
    );
  }

  Widget _tasksUncomplete(Task task) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text(
                    "Complete Task",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    task.task,
                    // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButtom(
                    onPressed: () {
                      //database request
                    },
                    buttonText: "Complete",
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                  ),
                ]),
              ),
            );
          },
        );
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(
                      "Delete Task",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      task.task,
                      // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Time",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CustomButtom(
                      onPressed: () {
                        //database request
                      },
                      buttonText: "Delete",
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                    ),
                  ]),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
            Text(task.task),
          ],
        ),
      ),
    );
  }

  Widget _tasksComplete(Task task) {
    return InkWell(
      onTap: () {
        //complete task
      },
      onLongPress: () {
        //delete task
      },
      child: Container(
        foregroundDecoration: BoxDecoration(color: Color(0x60fdfdfd)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
              Text(task.task),
            ],
          ),
        ),
      ),
    );
  }
}
