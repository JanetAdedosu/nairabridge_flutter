//import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Home Screen', style: TextStyle(fontSize: 24)),
//     );
//   }
// }

// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/wallet/wallet_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('NairaBridge')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Wallet Balance", style: TextStyle(fontSize: 18)),
            Text("₦${wallet.balance.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => wallet.topUp(5000),
              child: Text("Top Up ₦5,000"),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/transfer'),
              child: Text("Go to Transfer"),
            ),
          ],
        ),
      ),
    );
  }
}


