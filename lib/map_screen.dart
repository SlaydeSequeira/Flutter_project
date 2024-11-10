

// map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(19.2183, 72.9781); // Thane location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        backgroundColor: Colors.deepPurple,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: {
          Marker(
            markerId: const MarkerId('thane_marker'),
            position: _initialPosition,
            infoWindow: const InfoWindow(
              title: 'Thane Gaming Center',
              snippet: 'New game in Thane: Valorant!',
            ),
          ),
        },
      ),
    );
  }
}

