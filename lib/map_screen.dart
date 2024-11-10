import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Example',
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(19.2183, 72.9781);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addInitialMarker(); // Add the initial marker in initState
  }

  void _addInitialMarker() {
    _markers.add(Marker(
      markerId: const MarkerId('thane_marker'),
      position: _initialPosition,
      infoWindow: const InfoWindow(
        title: 'Thane Gaming Center',
        snippet: 'New game in Thane: Valorant!',
      ),
    ));
  }


  void _updateMarkers(List<LatLng> locations) {
    setState(() {
      _markers = locations.map((location) => Marker(
        markerId: MarkerId(location.toString()),
        position: location,
      )).toSet();
    });
  }

  // Example of how to update the camera position
  void _goToLocation(LatLng location) {
    mapController.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: location,
        northeast: location, // Using the same location for a tight zoom
      ),
      64, // padding in pixels around the bounds
    ));

  }


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
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Move the camera to a new location (replace with your logic)
          LatLng newLocation = const LatLng(19.0760, 72.8777); // Mumbai (example)
          _goToLocation(newLocation);

          // Example: Update markers (replace with your data)
          List<LatLng> newMarkers = [
            newLocation,
            const LatLng(19.2183, 72.9781), // Thane
          ];
          _updateMarkers(newMarkers);

        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}