import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGameCard(
            'FIFA 23 Tournaments',
            'https://example.com/fifa23-banner.jpg', // Replace with a real image URL
          ),
          const SizedBox(height: 16),
          _buildGameCard(
            'Valorant Matchmaking',
            'https://example.com/valorant-matchmaking.jpg', // Replace with a real image URL
          ),
          const SizedBox(height: 16),
          _buildGameCard(
            'Chess Championship',
            'https://example.com/chess.jpg', // Replace with a real image URL
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(String title, String imageUrl) {
    return Card(
      color: const Color(0xFF2C2C34),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          // Navigate to specific game details if required
        },
      ),
    );
  }
}
// TODO Implement this library.