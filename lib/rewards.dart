import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  final int userCP; // Pass user CP to manage balance deduction
  RewardScreen({Key? key, required this.userCP}) : super(key: key); // No more const : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Rewards list with name and CP required
    final List<Map<String, dynamic>> rewards = [
      {'name': '15 Mins', 'cp': 5000},
      {'name': '30 Mins', 'cp': 9000},
      {'name': '1 Hour', 'cp': 16000},
      {'name': '1 Day', 'cp': 50000},
      {'name': 'Tournament Pass', 'cp': 10000},
      {'name': 'PS Controller', 'cp': 1000000},
      {'name': 'PS 5', 'cp': 10000000},
      {'name': 'Controller Skin', 'cp': 50000},
      {'name': 'Mouse', 'cp': 70000},
      {'name': 'Keyboard', 'cp': 150000},
      {'name': 'Headphone', 'cp': 200000},
      {'name': 'Goodies', 'cp': 70000},
      {'name': 'Tee', 'cp': 50000},
      {'name': 'Gaming Chair', 'cp': 5000000},
    ];

    void redeemReward(int requiredCP, String rewardName) {
      if (userCP >= requiredCP) {
        // Deduct CP and log in the database
        // Implement your backend logic to update CP and log redemption here
        print('Redeemed: $rewardName');
      } else {
        print('Not enough CP');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
      ),
      body: ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(reward['name']),
              subtitle: Text('${reward['cp']} CP'),
              trailing: ElevatedButton(
                onPressed: () {
                  redeemReward(reward['cp'], reward['name']);
                },
                child: const Text('Redeem'),
              ),
            ),
          );
        },
      ),
    );
  }
}
