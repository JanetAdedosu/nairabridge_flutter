import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../wallet/wallet_provider.dart';
import '../navigation/navigation_provider.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _amountController = TextEditingController();

  /// Selected currency
  String _selectedCurrency = 'USD';

  /// Exchange rates (example values)
  final Map<String, double> _rates = {
    'USD': 0.00064,
    'EUR': 0.00059,
    'GBP': 0.00051,
  };

  /// Currency symbols
  final Map<String, String> _symbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
  };

  /// Flags
  final Map<String, String> _flags = {
    'USD': '🇺🇸',
    'EUR': '🇪🇺',
    'GBP': '🇬🇧',
  };

  double get _ngnAmount =>
      double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;

  double get _convertedAmount =>
      _ngnAmount * (_rates[_selectedCurrency] ?? 0);

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    final nav = Provider.of<NavigationProvider>(context, listen: false);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      /// ===========================
      /// APP BAR WITH BACK BUTTON
      /// ===========================
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            // 🔥 Proper fintech navigation (tab switch, not pop)
            nav.setIndex(0); // Go back to Home tab
          },
        ),
        title: const Text('Transfer'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ===========================
            /// YOU SEND CARD
            /// ===========================
            _card(
              theme,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('You send'),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Text(
                        '🇳🇬 NGN',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),

                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            hintText: '0.00',

                            // 🔥 Remove all lines/borders
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,

                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),

                  const Divider(),

                  Text(
                    'Available: ₦${wallet.balance.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ===========================
            /// CURRENCY SELECTOR
            /// ===========================
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Convert to',
                style: theme.textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['USD', 'EUR', 'GBP'].map((currency) {
                final selected = currency == _selectedCurrency;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCurrency = currency;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? theme.colorScheme.primary
                          : theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? theme.colorScheme.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(_flags[currency]!),
                        const SizedBox(width: 6),
                        Text(
                          currency,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// ===========================
            /// THEY RECEIVE CARD
            /// ===========================
            _card(
              theme,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('You receive'),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Text(
                        '${_flags[_selectedCurrency]} $_selectedCurrency',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        '${_symbols[_selectedCurrency]}${_convertedAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const Divider(),

                  Text(
                    'Rate: ₦1 = ${_symbols[_selectedCurrency]}${_rates[_selectedCurrency]}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text('Fee: ₦0', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text(
                    'Delivery: Instant',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// ===========================
            /// CONTINUE BUTTON
            /// ===========================
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _ngnAmount > 0 && _ngnAmount <= wallet.balance
                    ? () {
                        // Next step: confirmation screen
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===========================
  /// REUSABLE CARD CONTAINER
  /// ===========================
  Widget _card(ThemeData theme, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.04),
          ),
        ],
      ),
      child: child,
    );
  }
}
