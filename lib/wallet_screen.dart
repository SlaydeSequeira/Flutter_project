
// wallet_screen.dart (Create this new file)
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Wallet"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context); // Handle back button press
              },
              icon: const Icon(Icons.arrow_back))),

      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to full width
          children: [

            Card( // Use a card for the Balance section
              color: Theme.of(context).primaryColorDark, //Match app dark theme
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Current Balance",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "₹ 1000",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16), // Space between elements


            ElevatedButton(
              onPressed: () {}, // Add Top-up logic here
              style: ElevatedButton.styleFrom(
                backgroundColor:
                Theme.of(context).primaryColorDark, //Dark theme color
              ),
              child: const Text("TOPUP WALLET +"),
            ),
            const SizedBox(height: 16),

            Card( // Card for benefits
              color: Theme.of(context).primaryColorDark,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Wallet Benefits", style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    // Create the table here (see updated code below)
                    // ... your table code will go here ...

                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Pay',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'You Get',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'On Usage',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('₹ 800')),
                            DataCell(Text('₹ 820')),
                            DataCell(Text('+ 25 CP')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('₹ 1000')),
                            DataCell(Text('₹ 1050')),
                            DataCell(Text('+ 60 CP')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('₹ 5000')),
                            DataCell(Text('₹ 5500')),
                            DataCell(Text('+ 800 CP')),
                          ],
                        ),
                      ],
                    ),




                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}// TODO Implement this library.