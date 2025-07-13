//import 'package:flutter/material.dart';

// class TransferScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Transfer')),
//       body: Center(child: Text('Welcome to Transfer Screen')),
//     );
//   }
// }

// lib/screens/transfer_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../wallet/wallet_provider.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _nairaController = TextEditingController();
  final _convertedController = TextEditingController();

  String _selectedCurrency = 'USD';
  double _mockExchangeRate = 0.0011;

  void _transfer(WalletProvider wallet) {
    double nairaAmount = double.tryParse(_nairaController.text) ?? 0;
    if (nairaAmount <= 0) return;

    if (wallet.spend(nairaAmount)) {
      double converted = nairaAmount * _mockExchangeRate;
      _convertedController.text = converted.toStringAsFixed(2);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Transferred ₦$nairaAmount to $_selectedCurrency"),
        backgroundColor: Colors.green,
      ));
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Insufficient Balance"),
          content: Text("Top up your wallet to complete this transfer."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Transfer Funds")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nairaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount in Naira (₦)"),
            ),
            DropdownButton<String>(
              value: _selectedCurrency,
              items: ['USD', 'EUR', 'GBP'].map((String currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedCurrency = val!),
            ),
            TextField(
              controller: _convertedController,
              readOnly: true,
              decoration:
                  InputDecoration(labelText: "Converted ($_selectedCurrency)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _transfer(wallet),
              child: Text("Transfer Now"),
            ),
          ],
        ),
      ),
    );
  }
}
