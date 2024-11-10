// main.dart
import 'package:flutter/material.dart';
import 'qr_screen.dart';
import 'games_screen.dart';
import 'settings_screen.dart';
import 'map_screen.dart';
import 'home_screen.dart'; // Import home_screen.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaming UI with Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(),
        '/qr': (context) => const QRScreen(),
        '/games': (context) => const GamesScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

