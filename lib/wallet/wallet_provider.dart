// lib/wallet/wallet_provider.dart
import 'package:flutter/foundation.dart';

class WalletProvider extends ChangeNotifier {
  double _balance = 0;

  double get balance => _balance;

  void topUp(double amount) {
    _balance += amount;
    notifyListeners();
  }

  bool spend(double amount) {
    if (_balance >= amount) {
      _balance -= amount;
      notifyListeners();
      return true;
    }
    return false;
  }
}
