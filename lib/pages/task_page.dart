import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/database.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/custom_button.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Database provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);
    return StreamProvider.value(
      value: provider.getTodoByType(TodoType.TYPE_TASK.index),
      child: Consumer<List<TodoData>>(
        builder: (context, _dataList, child) {
          return _dataList == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return _dataList[index].isFinish
                        ? _tasksComplete(_dataList[index])
                        : _tasksUncomplete(_dataList[index]);
                  },
                );
        },
      ),
    );
  }

  Widget _tasksUncomplete(TodoData task) {
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
                    new DateFormat('dd-MM-yyyy').format(task.date),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButtom(
                    onPressed: () {
                      provider
                          .completeTodoEntries(task.id)
                          .whenComplete(Navigator.of(context).pop);
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
                      new DateFormat('dd-MM-yyyy').format(task.date),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CustomButtom(
                      onPressed: () {
                        provider
                            .deleteTodoEntrie(task.id)
                            .whenComplete(Navigator.of(context).pop);
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

  Widget _tasksComplete(TodoData task) {
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
                      new DateFormat('dd-MM-yyyy').format(task.date),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CustomButtom(
                      onPressed: () {
                        provider
                            .deleteTodoEntrie(task.id)
                            .whenComplete(Navigator.of(context).pop);
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
