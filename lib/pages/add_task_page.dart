import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_textfield.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "add new task",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          CustomTextField(labelText: "Enter task name"),
          SizedBox(
            height: 24,
          ),
          _actionButton(context),
        ],
      ),
    );
  }

  Row _actionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButtom(
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: "Close",
          color: Colors.white,
          textColor: Theme.of(context).accentColor,
        ),
        CustomButtom(
          onPressed: () {},
          buttonText: "Save",
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}
