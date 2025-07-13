import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // for managing state with provider
import 'package:nairabridge_flutter/screens/home_screen.dart';
import 'package:nairabridge_flutter/screens/transfer_screen.dart';
import 'package:nairabridge_flutter/wallet/wallet_provider.dart';

void main() {
  runApp(NairabridgeApp());
}

class NairabridgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalletProvider(), // Providing wallet state globally
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // This line removes the DEBUG banner
        title: 'Naira Bridge',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        home: NavigationWrapper(), // Your screen switcher
        routes: {
          '/transfer': (context) => TransferScreen(), // 👈 You can now use this route if needed
        },
      ),
    );
  }
}

class NavigationWrapper extends StatefulWidget {
  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 0;

  // List of screens to navigate between
  final List<Widget> _screens = [
    HomeScreen(), // Home screen with wallet functionality
    TransferScreen(), // Transfer screen to manage transfers
  ];

  // Handling tab switch
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Dynamically render the screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the current tab
        onTap: _onTabTapped, // Update the screen on tab tap
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Home icon
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz), // Transfer icon
            label: 'Transfer',
          ),
        ],
      ),
    );
  }
}
