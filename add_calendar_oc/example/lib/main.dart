import 'package:flutter/material.dart';
import 'package:add_calendar_oc/add_calendar_oc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  _add() async {
    await AddCalendarOc.addCalendar(
      'title',
      'notes',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      lication: '北京',
      allDay: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(),
        floatingActionButton: FloatingActionButton(onPressed: _add),
      ),
    );
  }
}
