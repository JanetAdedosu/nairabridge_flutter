import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../wallet/wallet_provider.dart';

enum Currency { usd, eur, gbp }

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _nairaController = TextEditingController();

  Currency _selectedCurrency = Currency.usd;

  final Map<Currency, double> _rates = {
    Currency.usd: 0.0011,
    Currency.eur: 0.0010,
    Currency.gbp: 0.0009,
  };

  final Map<Currency, String> _symbols = {
    Currency.usd: '\$',
    Currency.eur: '€',
    Currency.gbp: '£',
  };

  final Map<Currency, String> _labels = {
    Currency.usd: 'USD',
    Currency.eur: 'EUR',
    Currency.gbp: 'GBP',
  };

  double get _converted {
    final amount = double.tryParse(_nairaController.text) ?? 0;
    return amount * _rates[_selectedCurrency]!;
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        centerTitle: true,
      ),

      /// Main content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// BALANCE CARD (matches visual)
            _InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Available balance'),
                  const SizedBox(height: 6),
                  Text(
                    '₦${wallet.balance.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineLarge,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// YOU SEND CARD
            _InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('You send'),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nairaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: '₦ ',
                      hintText: 'Enter amount',
                      border: InputBorder.none,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// RECIPIENT GETS CARD
            _InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recipient gets'),
                  const SizedBox(height: 16),

                  /// Currency pills
                  Row(
                    children: Currency.values.map((currency) {
                      final selected = currency == _selectedCurrency;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCurrency = currency;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: selected
                                  ? theme.colorScheme.primary
                                  : theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: theme.dividerColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _labels[currency]!,
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : theme.textTheme.bodyLarge!.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  /// Converted amount
                  Text(
                    '${_symbols[_selectedCurrency]}${_converted.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// PRIMARY CTA (fixed bottom)
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(_nairaController.text) ?? 0;

              if (amount <= 0 || amount > wallet.balance) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Invalid amount or insufficient balance'),
                  ),
                );
                return;
              }

              wallet.decreaseBalance(amount);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transfer successful')),
              );

              _nairaController.clear();
            },
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable card widget (keeps UI consistent)
class _InfoCard extends StatelessWidget {
  final Widget child;

  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }
}
