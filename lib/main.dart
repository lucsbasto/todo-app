import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _mainContent(context),
          Positioned(
            right: 0,
            child: Text(
              "6",
              style: TextStyle(fontSize: 200, color: Color(0x10000000)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Column _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 70, bottom: 50),
          child: Text(
            "Monday",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(context),
        ),
        _tasksUncomplete("Call tom about appointment"),
        _tasksUncomplete("Edit API documentation"),
        _tasksUncomplete("Fix on boarding experience"),
        Divider(),
        SizedBox(height: 16),
        _tasksComplete("Have coffee with Sam"),
        _tasksComplete("Clean my bedroom"),
      ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 24.0),
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
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            onPressed: () {},
            child: Text('Tasks'),
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(14.0),
            textColor: Colors.white,
          ),
        ),
        SizedBox(
          width: 32,
        ),
        Expanded(
          child: MaterialButton(
            onPressed: () {},
            child: Text('Events'),
            padding: EdgeInsets.all(14.0),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(12),
            ),
            textColor: Theme.of(context).accentColor,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
