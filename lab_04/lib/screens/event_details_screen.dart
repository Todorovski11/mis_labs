import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Details',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text('Date: ${event.date.toLocal()}'),
            Text('Location: ${event.location}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement navigation to map screen or set reminder
              },
              child: const Text('Navigate to Location'),
            ),
          ],
        ),
      ),
    );
  }
}
