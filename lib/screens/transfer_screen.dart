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
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../wallet/wallet_provider.dart';

// class TransferScreen extends StatefulWidget {
//   @override
//   _TransferScreenState createState() => _TransferScreenState();
// }

// class _TransferScreenState extends State<TransferScreen> {
//   final _nairaController = TextEditingController();
//   final _convertedController = TextEditingController();

//   String _selectedCurrency = 'USD';
//   double _mockExchangeRate = 0.0011;

//   void _transfer(WalletProvider wallet) {
//     double nairaAmount = double.tryParse(_nairaController.text) ?? 0;
//     if (nairaAmount <= 0) return;

//     if (wallet.spend(nairaAmount)) {
//       double converted = nairaAmount * _mockExchangeRate;
//       _convertedController.text = converted.toStringAsFixed(2);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Transferred ₦$nairaAmount to $_selectedCurrency"),
//         backgroundColor: Colors.green,
//       ));
//     } else {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text("Insufficient Balance"),
//           content: Text("Top up your wallet to complete this transfer."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("OK"),
//             )
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final wallet = Provider.of<WalletProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text("Transfer Funds")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nairaController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: "Amount in Naira (₦)"),
//             ),
//             DropdownButton<String>(
//               value: _selectedCurrency,
//               items: ['USD', 'EUR', 'GBP'].map((String currency) {
//                 return DropdownMenuItem(
//                   value: currency,
//                   child: Text(currency),
//                 );
//               }).toList(),
//               onChanged: (val) => setState(() => _selectedCurrency = val!),
//             ),
//             TextField(
//               controller: _convertedController,
//               readOnly: true,
//               decoration:
//                   InputDecoration(labelText: "Converted ($_selectedCurrency)"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _transfer(wallet),
//               style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               backgroundColor: Colors.indigo,
//               foregroundColor: Colors.white,
//               textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//                ),
//               elevation: 4,
//            ),


//               child: Text("Transfer Now"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//IMPORTNANT BEFORE ADDING THE COUNTRY FLAG
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../wallet/wallet_provider.dart';

// class TransferScreen extends StatefulWidget {
//   @override
//   _TransferScreenState createState() => _TransferScreenState();
// }

// class _TransferScreenState extends State<TransferScreen> {
//   final TextEditingController _nairaController = TextEditingController();
//   final TextEditingController _convertedController = TextEditingController();
//   String _selectedCurrency = 'USD';

//   final Map<String, double> _exchangeRates = {
//     'USD': 0.0012,
//     'EUR': 0.0011,
//     'GBP': 0.0010,
//   };

//   void _convert() {
//     final input = double.tryParse(_nairaController.text);
//     if (input != null) {
//       final rate = _exchangeRates[_selectedCurrency] ?? 0;
//       final converted = input * rate;
//       _convertedController.text = converted.toStringAsFixed(2);
//     } else {
//       _convertedController.text = '';
//     }
//   }

//   void _transfer(WalletProvider wallet) {
//     final input = double.tryParse(_nairaController.text);
//     if (input != null && input <= wallet.balance) {
//       wallet.decreaseBalance(input);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Transferred ₦$input to $_selectedCurrency")),
//       );
//       _nairaController.clear();
//       _convertedController.clear();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Insufficient balance or invalid amount")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final wallet = Provider.of<WalletProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text("Transfer Funds")),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Wallet Balance: ₦${wallet.balance.toStringAsFixed(2)}",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _nairaController,
//                 keyboardType: TextInputType.number,
//                 onChanged: (_) => _convert(),
//                 decoration: InputDecoration(
//                   labelText: "Amount in Naira (₦)",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               DropdownButton<String>(
//                 value: _selectedCurrency,
//                 isExpanded: true,
//                 items: ['USD', 'EUR', 'GBP'].map((String currency) {
//                   return DropdownMenuItem(
//                     value: currency,
//                     child: Text(currency),
//                   );
//                 }).toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     _selectedCurrency = val!;
//                     _convert(); // Recalculate on currency change
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _convertedController,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: "Converted ($_selectedCurrency)",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 30),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => _transfer(wallet),
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                     backgroundColor: Colors.indigo,
//                     foregroundColor: Colors.white,
//                     textStyle: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 4,
//                   ),
//                   child: Text("Convert Now"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// //the one i was using 
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../wallet/wallet_provider.dart';

// class TransferScreen extends StatefulWidget {
//   @override
//   _TransferScreenState createState() => _TransferScreenState();
// }

// class _TransferScreenState extends State<TransferScreen> {
//   final TextEditingController _nairaController = TextEditingController();
//   final TextEditingController _convertedController = TextEditingController();
//   String _selectedCurrency = 'USD';

//   final Map<String, double> _exchangeRates = {
//     'USD': 0.0011,
//     'EUR': 0.0010,
//     'GBP': 0.0009,
//   };

//   final Map<String, String> _currencySymbols = {
//     'USD': '\$',
//     'EUR': '€',
//     'GBP': '£',
//     'NGN': '₦',
//   };

//   final Map<String, String> _currencyFlags = {
//     'USD': '🇺🇸',
//     'EUR': '🇪🇺',
//     'GBP': '🇬🇧',
//     'NGN': '🇳🇬',
//   };

//   void _convert() {
//     final input = double.tryParse(_nairaController.text) ?? 0;
//     final rate = _exchangeRates[_selectedCurrency]!;
//     final converted = input * rate;

//     _convertedController.text =
//         "${_currencySymbols[_selectedCurrency]}${converted.toStringAsFixed(2)}";
//   }

//   void _transfer(WalletProvider wallet) {
//     final input = double.tryParse(_nairaController.text) ?? 0;

//     if (input > 0 && input <= wallet.balance) {
//       wallet.decreaseBalance(input);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Transferred ₦$input to $_selectedCurrency")),
//       );
//       _nairaController.clear();
//       _convertedController.clear();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Invalid amount or insufficient balance")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final wallet = Provider.of<WalletProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text("Transfer Funds")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nairaController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Amount in Naira",
//                 prefixText: '${_currencyFlags['NGN']} ${_currencySymbols['NGN']}',
//               ),
//               onChanged: (_) => _convert(),
//             ),
//             SizedBox(height: 20),
//             DropdownButton<String>(
//               value: _selectedCurrency,
//               isExpanded: true,
//               items: ['USD', 'EUR', 'GBP'].map((String currency) {
//                 return DropdownMenuItem(
//                   value: currency,
//                   child: Text('${_currencyFlags[currency]} ${_currencySymbols[currency]} $currency'),
//                 );
//               }).toList(),
//               onChanged: (val) {
//                 setState(() => _selectedCurrency = val!);
//                 _convert();
//               },
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _convertedController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText:
//                     "Converted (${_currencyFlags[_selectedCurrency]} ${_currencySymbols[_selectedCurrency]})",
//                 prefixText: '${_currencySymbols[_selectedCurrency]}',
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _transfer(wallet),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                 backgroundColor: Colors.indigo,
//                 foregroundColor: Colors.white,
//                 textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 4,
//               ),
//               child: Text("Transfer Now"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../wallet/wallet_provider.dart';

class TransferScreen extends StatefulWidget {
  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _nairaController = TextEditingController();
  final TextEditingController _convertedController = TextEditingController();

  String _selectedCurrency = 'USD';

  final Map<String, double> _exchangeRates = {
    'USD': 0.0011,
    'EUR': 0.0010,
    'GBP': 0.0009,
  };

  final Map<String, String> _symbols = {
    'NGN': '₦',
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
  };

  void _convert() {
    final amount = double.tryParse(_nairaController.text) ?? 0;
    final rate = _exchangeRates[_selectedCurrency]!;
    _convertedController.text =
        (amount * rate).toStringAsFixed(2);
  }

  void _confirmTransfer(WalletProvider wallet, double amount) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm transfer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You send: ₦${amount.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(
              'They receive: ${_symbols[_selectedCurrency]}${_convertedController.text}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              wallet.decreaseBalance(amount);
              _nairaController.clear();
              _convertedController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transfer successful')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _amountCard({
    required String title,
    required String currency,
    required String symbol,
    required TextEditingController controller,
    bool editable = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                currency,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SizedBox(
                width: 160,
                child: TextField(
                  controller: controller,
                  readOnly: !editable,
                  textAlign: TextAlign.right,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText:  '${symbol}0.00',

                    border: InputBorder.none,
                  ),
                  onChanged: (_) => _convert(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    final amount = double.tryParse(_nairaController.text) ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Transfer'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available balance: ₦${wallet.balance.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            _amountCard(
              title: 'You send',
              currency: 'NGN',
              symbol: _symbols['NGN']!,
              controller: _nairaController,
            ),

            const SizedBox(height: 16),

            _amountCard(
              title: 'They receive',
              currency: _selectedCurrency,
              symbol: _symbols[_selectedCurrency]!,
              controller: _convertedController,
              editable: false,
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['USD', 'EUR', 'GBP'].map((currency) {
                final selected = _selectedCurrency == currency;
                return ChoiceChip(
                  label: Text(currency),
                  selected: selected,
                  selectedColor: Colors.indigo,
                  onSelected: (_) {
                    setState(() => _selectedCurrency = currency);
                    _convert();
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            Text(
              'Rate: ₦1 = ${_exchangeRates[_selectedCurrency]} $_selectedCurrency',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: amount > 0 && amount <= wallet.balance
                    ? () => _confirmTransfer(wallet, amount)
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
