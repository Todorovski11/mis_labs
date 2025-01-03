import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event.dart';
import '../services/database_service.dart';
import 'add_event_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<Event>> _events;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _events = {};
    _loadEvents(); // Load events from the database
  }

  void _loadEvents() async {
    final List<Event> events = await DatabaseService.getEvents();
    setState(() {
      _events = {};
      for (var event in events) {
        final eventDate = DateTime(event.date.year, event.date.month, event.date.day);
        if (_events[eventDate] == null) {
          _events[eventDate] = [];
        }
        _events[eventDate]!.add(event);
      }
    });
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Schedule')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          const SizedBox(height: 16),
          ..._getEventsForDay(_selectedDate).map((event) => ListTile(
                title: Text(event.title),
                subtitle: Text(event.location),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? isAdded = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEventScreen()),
          );
          if (isAdded == true) {
            _loadEvents(); // Refresh events after adding
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
