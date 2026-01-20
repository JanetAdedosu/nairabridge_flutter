import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../wallet/wallet_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NairaBridge'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// WALLET BALANCE CARD
            _WalletCard(
              balance: wallet.balance,
            ),

            const SizedBox(height: 30),

            /// QUICK ACTIONS
            Text(
              'Quick actions',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _ActionButton(
                  icon: Icons.swap_horiz_rounded,
                  label: 'Send',
                  onTap: () {
                    // Switch to transfer tab
                    DefaultTabController.of(context);
                  },
                ),
                const SizedBox(width: 12),
                _ActionButton(
                  icon: Icons.call_received_rounded,
                  label: 'Receive',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Receive coming soon')),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _ActionButton(
                  icon: Icons.add_circle_outline,
                  label: 'Add',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Add money coming soon')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            /// RECENT ACTIVITY PLACEHOLDER
            Text(
              'Recent activity',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            _EmptyStateCard(),
          ],
        ),
      ),
    );
  }
}

/// WALLET CARD (matches fintech visual)
class _WalletCard extends StatelessWidget {
  final double balance;

  const _WalletCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Wallet balance',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            '₦${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// ACTION BUTTON (Send / Receive / Add)
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// EMPTY STATE FOR ACTIVITY
class _EmptyStateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          Icon(Icons.receipt_long_outlined, size: 40),
          SizedBox(height: 12),
          Text(
            'No transactions yet',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            'Your recent transfers will appear here',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
