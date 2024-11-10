import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateQRScreen extends StatefulWidget {
  const GenerateQRScreen({super.key});

  @override
  State<GenerateQRScreen> createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
  final TextEditingController _userIdController = TextEditingController();
  bool isCheckIn = true;
  String qrData = '';

  @override
  void initState() {
    super.initState();
    _loadLastState();
  }

  Future<void> _loadLastState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCheckIn = prefs.getBool('isCheckIn') ?? true;
    });
  }


  Future<void> _toggleCheckInOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCheckIn = !isCheckIn;
    });
    await prefs.setBool('isCheckIn', isCheckIn);
  }

  void _generateQR() {
    final String userId = _userIdController.text.trim();
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a User ID')),
      );
      return;
    }

    final String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final String action = isCheckIn ? 'Check-In' : 'Check-Out';

    final Map<String, dynamic> qrDataMap = {
      'userId': userId,
      'timestamp': timestamp,
      'action': action,
    };

    setState(() {
      qrData = jsonEncode(qrDataMap);
    });

    _toggleCheckInOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Generate QR Code'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Enter User ID and Generate QR:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateQR,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Generate QR Code'),
            ),
            const SizedBox(height: 20),
            if (qrData.isNotEmpty) ...[
              const Text(
                'Scan this QR code:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Center(
                child: QrImageView(  // Use QrImageView
                  data: qrData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Next action: ${isCheckIn ? "Check-Out" : "Check-In"}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}