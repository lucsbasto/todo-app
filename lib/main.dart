import 'package:flutter/material.dart';
import 'package:todo_app/pages/add_event_page.dart';
import 'package:todo_app/pages/add_task_page.dart';
import 'package:todo_app/pages/event_page.dart';
import 'package:todo_app/pages/task_page.dart';
import 'package:todo_app/widgets/custom_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: "Montserrat"),
      home: MyHomePage(),
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
  PageController _pageController = PageController();
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

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
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: currentPage == 0 ? AddTaskPage() : AddEventPage(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              );
            },
          );
        },
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

  Widget _mainContent(BuildContext context) {
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
        Expanded(
          child: PageView(
            controller: _pageController,
            children: <Widget>[TaskPage(), EventPage()],
          ),
        ),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomButtom(
            buttonText: 'Tasks',
            onPressed: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceIn);
            },
            color: currentPage >= 0.5
                ? Theme.of(context).accentColor
                : Colors.white,
            textColor: currentPage >= 0.5
                ? Colors.white
                : Theme.of(context).accentColor,
            borderColor: currentPage >= 0.5
                ? Colors.transparent
                : Theme.of(context).accentColor,
          ),
        ),
        SizedBox(
          width: 32,
        ),
        Expanded(
          child: CustomButtom(
            buttonText: 'Events',
            onPressed: () {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceIn);
            },
            color: currentPage <= 0.5
                ? Theme.of(context).accentColor
                : Colors.white,
            textColor: currentPage <= 0.5
                ? Colors.white
                : Theme.of(context).accentColor,
            borderColor: currentPage <= 0.5
                ? Colors.transparent
                : Theme.of(context).accentColor,
          ),
        )
      ],
    );
  }
}
