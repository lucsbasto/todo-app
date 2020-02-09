import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/database.dart';
import 'package:todo_app/widgets/custom_icon_decoration.dart';
import 'package:todo_app/models/todo.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class Event {
  final String time;
  final String task;
  final String description;
  final bool isFinish;

  const Event(this.time, this.task, this.description, this.isFinish);
}

final List<Event> _eventList = [
  new Event("08:00", "Have coffee with Sam", "Personal", false),
  new Event("09:00", "Meet with sales", "Personal", true),
  new Event("10:00", "Call about the appointment", "Personal", false),
  new Event("11:00", "Fix onboarding experience", "Personal", false),
  new Event("12:00", "Edit API documentation", "Personal", true),
  new Event("13:00", "Setup user focus group", "Personal", false),
];

class _EventPageState extends State<EventPage> {
  Database provider;

  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    provider = Provider.of<Database>(context);
    return StreamProvider.value(
        value: provider.getTodoByType(TodoType.TYPE_TASK.index),
        child: Consumer<List<TodoData>>(builder: (context, _datalist, child) {
          return _datalist == null
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _datalist.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Row(
                        children: <Widget>[
                          _lineStyle(context, iconSize, index, _datalist.length,
                              _datalist[index].isFinish),
                          _displayTime(_datalist[index].time),
                          _displayContent(_datalist[index]),
                        ],
                      ),
                    );
                  });
        }));
  }

  Expanded _displayContent(TodoData event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x20000000), blurRadius: 5, offset: Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.task),
              SizedBox(
                height: 12,
              ),
              Text(event.description)
            ],
          ),
        ),
      ),
    );
  }

  Container _displayTime(DateTime time) {
    return Container(
      width: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(child: Text(time.toString())),
      ),
    );
  }

  Container _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
    return Container(
      decoration: CustomIconDecoration(
        iconSize: iconSize,
        lineWidth: 1,
        firstData: index == 0 ?? false,
        lastData: index == listLength - 1 ?? false,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3),
                  color: Color(0x20000000),
                  blurRadius: 5),
            ]),
        child: Icon(
            isFinish ? Icons.fiber_manual_record : Icons.radio_button_unchecked,
            size: 20,
            color: Theme.of(context).accentColor),
      ),
    );
  }
}
