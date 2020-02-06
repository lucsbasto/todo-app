import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

final List<Event> _event_list = [
  new Event("08:00", "Have coffee with Sam", "Personal", false),
  new Event("09:00", "Meet with sales", "Personal", true),
  new Event("10:00", "Call about the appointment", "Personal", false),
  new Event("11:00", "Fix onboarding experience", "Personal", false),
  new Event("12:00", "Edit API documentation", "Personal", true),
  new Event("13:00", "Setup user focus group", "Personal", false),
];

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;

    return ListView.builder(
      itemCount: _event_list.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: IconDecoration(
                  iconSize: iconSize,
                  lineWidth: 1,
                  firstData: index == 0 ?? false,
                  lastData: index == _event_list.length - 1 ?? false,
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
                      _event_list[index].isFinish
                          ? Icons.fiber_manual_record
                          : Icons.radio_button_unchecked,
                      size: 20,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child:
                    Container(width: 80, child: Text(_event_list[index].time)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x20000000),
                            blurRadius: 5,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_event_list[index].task),
                        SizedBox(
                          height: 12,
                        ),
                        Text(_event_list[index].description)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class IconDecoration extends Decoration {
  final double iconSize;
  final double lineWidth;
  final bool firstData;
  final bool lastData;

  IconDecoration({
    @required double iconSize,
    @required double lineWidth,
    @required bool firstData,
    @required bool lastData,
  })  : this.iconSize = iconSize,
        this.lineWidth = lineWidth,
        this.firstData = firstData,
        this.lastData = lastData;

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return IconLine(
        iconSize: iconSize,
        lineWidth: lineWidth,
        firstData: firstData,
        lastData: lastData);
  }
}

class IconLine extends BoxPainter {
  final double iconSize;
  final bool firstData;
  final bool lastData;

  final Paint paintLine;

  IconLine({
    @required double iconSize,
    @required double lineWidth,
    @required bool firstData,
    @required bool lastData,
  })  : this.iconSize = iconSize,
        this.firstData = firstData,
        this.lastData = lastData,
        paintLine = Paint()
          ..color = Colors.red
          ..strokeCap = StrokeCap.round
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final leftOffSet = Offset((iconSize / 2) + 24, offset.dy);
    final double iconSpace = iconSize / 1.5;
    final Offset top = configuration.size.topLeft(Offset(leftOffSet.dx, 0.0));
    final Offset centerTop = configuration.size
        .centerLeft(Offset(leftOffSet.dx, leftOffSet.dy - iconSpace));
    final Offset centerBottom = configuration.size
        .centerLeft(Offset(leftOffSet.dx, leftOffSet.dy + iconSpace));
    final Offset end =
        configuration.size.bottomLeft(Offset(leftOffSet.dx, leftOffSet.dy * 2));
    if (!firstData) canvas.drawLine(top, centerTop, paintLine);
    if (!lastData) canvas.drawLine(centerBottom, end, paintLine);
  }
}
