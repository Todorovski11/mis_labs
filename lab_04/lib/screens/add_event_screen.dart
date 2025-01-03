import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart'; // For LatLng
import '../models/event.dart';
import '../services/database_service.dart';
import 'location_picker_screen.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  LatLng? _selectedLocation;

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickLocation() async {
    final LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerScreen()),
    );

    if (pickedLocation != null) {
      setState(() {
        _selectedLocation = pickedLocation;
      });
    }
  }

  void _saveEvent() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedLocation != null) {
      final newEvent = Event(
        title: _titleController.text,
        date: _selectedDate!,
        location:
            'Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
      );

      await DatabaseService.insertEvent(newEvent);

      // Go back after saving
      Navigator.pop(context, true); // Pass true to indicate success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select a location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Event Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : 'Selected Date: ${_selectedDate!.toLocal()}',
                    ),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedLocation == null
                          ? 'No location selected'
                          : 'Selected Location: Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
                    ),
                  ),
                  TextButton(
                    onPressed: _pickLocation,
                    child: const Text('Select Location'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _saveEvent,
                  child: const Text('Save Event'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
