import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(41.9981, 21.4254), // Default to Skopje, Macedonia
          zoom: 13.0,
          onTap: (tapPosition, latLng) {
            setState(() {
              _selectedLocation = latLng;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (_selectedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _selectedLocation!,
                  builder: (ctx) => const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (_selectedLocation != null) {
              Navigator.pop(context, _selectedLocation);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a location')),
              );
            }
          },
          child: const Text('Confirm Location'),
        ),
      ),
    );
  }
}
