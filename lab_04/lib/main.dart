import 'package:flutter/material.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Exam Scheduler',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalendarScreen(),
    );
  }
}
