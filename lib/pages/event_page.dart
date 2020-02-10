import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/database.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_icon_decoration.dart';
import 'package:todo_app/models/todo.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Database provider;

  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    provider = Provider.of<Database>(context);
    return StreamProvider.value(
        value: provider.getTodoOrderBy(TodoType.TYPE_TASK.index),
        child: Consumer<List<TodoData>>(builder: (context, _datalist, child) {
          return _datalist == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _datalist.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    bool isFinished = (_datalist[index].isFinish ||
                        _datalist[index].time.isBefore(DateTime.now()));
                    return Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Row(
                        children: <Widget>[
                          _lineStyle(context, iconSize, index, _datalist.length,
                              isFinished),
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
      child: _inkWell(event),
    );
  }

  InkWell _inkWell(TodoData event) {
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
                  child: _dialogButton(
                      event, event.isFinish ? 'Delete' : 'Complete'),
                ),
              );
            });
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
                  child: _dialogButton(
                      event, event.isFinish ? 'Delete' : 'Complete'),
                ),
              );
            });
      },
      child: _eventBox(event),
    );
  }

  Widget _eventBox(TodoData event) {
    return Padding(
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
            Text(
              event.task,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              event.description,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _displayTime(DateTime datetime) {
    String time = DateFormat("HH:mm").format(datetime);
    String date = DateFormat("dd-MM").format(datetime);
    return Container(
      width: 80,
      child: Column(
        children: <Widget>[
          Container(child: Text(time)),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
          ),
          Container(child: Text(date)),
        ],
      ),
    );
  }

  Widget _lineStyle(BuildContext context, double iconSize, int index,
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

  Widget _dialogButton(TodoData event, String _text) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Text(
        "${_text} Event",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(
        height: 24,
      ),
      Text(
        event.task,
        // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(
        height: 24,
      ),
      Text(
        "${new DateFormat('dd-MM-yyyy').format(event.date)}  ${DateFormat("dd-MM").format(event.date)}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(
        height: 24,
      ),
      CustomButtom(
        onPressed: () {
          (event.date.isBefore(new DateTime.now()) || event.isFinish)
              ? provider
                  .deleteTodoEntries(event.id)
                  .whenComplete(Navigator.of(context).pop)
              : provider
                  .completeTodoEntries(event.id)
                  .whenComplete(Navigator.of(context).pop);
        },
        buttonText: _text,
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
      ),
    ]);
  }
}
