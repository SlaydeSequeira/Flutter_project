
// home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1A1E),
      appBar: AppBar(title: const Text('Home')),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B1A1E),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(Icons.qr_code, color: Colors.white),
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.white,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.popUntil(context, ModalRoute.withName('/home'));
              break;
            case 1:
              Navigator.pushNamed(context, '/map');
              break;
            case 2:
              Navigator.pushNamed(context, '/qr');
              break;
            case 3:
              Navigator.pushNamed(context, '/games');
              break;
            case 4:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Gaming App!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://example.com/valorant-banner.jpg', // Replace with a real image URL
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}


// TODO Implement this library.