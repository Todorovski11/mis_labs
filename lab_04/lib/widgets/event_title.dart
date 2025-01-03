import 'package:flutter/material.dart';
import '../models/event.dart';
import '../screens/event_details_screen.dart';

class EventTile extends StatelessWidget {
  final Event event;

  const EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.title),
      subtitle: Text('${event.date.toLocal()} at ${event.location}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
    );
  }
}
