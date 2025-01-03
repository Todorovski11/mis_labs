import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Locations')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.9981, 21.4254), // Example: Skopje, Macedonia
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('1'),
            position: const LatLng(41.9981, 21.4254),
            infoWindow: const InfoWindow(title: 'Exam Location'),
          ),
        },
      ),
    );
  }
}
