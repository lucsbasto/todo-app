import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/custom_date_time_picker.dart';
import 'package:todo_app/widgets/custom_modal_action_button.dart';
import 'package:todo_app/widgets/custom_textfield.dart';
import 'package:todo_app/models/database.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();
  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().add(Duration(days: -365)),
      lastDate: new DateTime.now().add(Duration(days: 365)),
    );
    if (datepick != null) setState(() => _selectedDate = datepick);
  }

  Future _pickTime() async {
    TimeOfDay timepick = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    if (timepick != null)
      setState(() {
        _selectedTime = timepick;
      });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Database>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "Add new event",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
            labelText: "Enter event name",
            controller: _eventNameController,
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
            labelText: "Enter description",
            controller: _eventDescriptionController,
          ),
          SizedBox(
            height: 12,
          ),
          CustomDateTimePicker(
              icon: Icons.date_range,
              onPressed: _pickDate,
              value: DateFormat('dd-MM-yyyy').format(_selectedDate)),
          CustomDateTimePicker(
            icon: Icons.access_time,
            onPressed: _pickTime,
            value: _selectedTime.toString(),
          ),
          SizedBox(
            height: 24,
          ),
          CustomModalActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              if (_eventNameController.text != "" &&
                  _eventDescriptionController.text != "") {
                provider
                    .insertTodoEntries(new TodoData(
                        date: _selectedDate,
                        time: new DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            _selectedTime.hour,
                            _selectedTime.minute),
                        isFinish: false,
                        task: _eventNameController.text,
                        description: _eventDescriptionController.text,
                        todoType: TodoType.TYPE_TASK.index,
                        id: null))
                    .whenComplete(Navigator.of(context).pop);
              }
            },
          ),
        ],
      ),
    );
  }
}
