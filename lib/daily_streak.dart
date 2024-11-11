import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'dart:math';

class DailyStreakScreen extends StatefulWidget {
  const DailyStreakScreen({Key? key}) : super(key: key);

  @override
  _DailyStreakScreenState createState() => _DailyStreakScreenState();
}

class _DailyStreakScreenState extends State<DailyStreakScreen> {
  final List<String> rewards = [
    '500 CP', '200 CP', 'T-Shirt', 'Better Luck Next Time', '100 CP', 'Goodies', '1000 CP', 'Better Luck Next Time'
  ];

  // Normalized probabilities (must sum to 1)
  final List<double> probabilities = [0.03, 0.1, 0.05, 0.4, 0.2, 0.1, 0.01, 0.11];
  final StreamController<int> selectedRewardController = StreamController<int>();

  @override
  void dispose() {
    selectedRewardController.close();
    super.dispose();
  }

  List<double> getCumulativeProbabilities() {
    double cumulative = 0;
    List<double> cumulativeProbabilities = [];
    for (var probability in probabilities) {
      cumulative += probability;
      cumulativeProbabilities.add(cumulative);
    }
    return cumulativeProbabilities;
  }

  int getWeightedRandomIndex() {
    final cumulativeProbabilities = getCumulativeProbabilities();
    final randomValue = Random().nextDouble();
    print("Random Value: $randomValue");  // Debug line

    for (int i = 0; i < cumulativeProbabilities.length; i++) {
      if (randomValue <= cumulativeProbabilities[i]) {
        print("Selected Index: $i");  // Debug line
        return i;
      }
    }
    print("Defaulting to last index");
    return cumulativeProbabilities.length - 1; // Default to last item
  }

  void spinWheel() {
    final selectedIndex = getWeightedRandomIndex();
    selectedRewardController.add(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Streak')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Daily Streak!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keep playing daily to increase your streak!',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 300,
              child: FortuneWheel(
                selected: selectedRewardController.stream,
                items: [
                  for (var reward in rewards)
                    FortuneItem(
                      child: Text(reward, style: TextStyle(color: Colors.white)),
                      style: FortuneItemStyle(color: Colors.blueAccent),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: spinWheel,
              child: const Text('Spin'),
            ),
          ],
        ),
      ),
    );
  }
}
