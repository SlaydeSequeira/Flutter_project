import 'package:flutter/material.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100, color: Colors.purple),
            const SizedBox(height: 20),
            const Text(
              'Scan a QR Code',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              onPressed: () {
                // Here you can integrate the QR scanning functionality using a package like `qr_code_scanner`
              },
              child: const Text('Start Scanning'),
            ),
          ],
        ),
      ),
    );
  }
}
