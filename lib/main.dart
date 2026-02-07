import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:nairabridge_flutter/screens/home_screen.dart';
import 'package:nairabridge_flutter/screens/transfer_screen.dart';

// Providers
import 'package:nairabridge_flutter/wallet/wallet_provider.dart';
import 'package:nairabridge_flutter/theme/theme_provider.dart';
import 'package:nairabridge_flutter/theme/app_theme.dart';

void main() async {
  // Ensures Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ThemeProvider and load saved theme
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        // Wallet state
        ChangeNotifierProvider(
          create: (_) => WalletProvider(),
        ),
        //Navigation state
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),

        // Theme state
        ChangeNotifierProvider(
          create: (_) => themeProvider,
        ),
      ],
      child: NairaBridgeApp(),
    ),
  );
}

/// Root widget of the application
class NairaBridgeApp extends StatelessWidget {
  const NairaBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NairaBridge',

      // App themes
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      // Main navigation wrapper
      home: NavigationWrapper(),
    );
  }
}

/// Handles bottom navigation between main sections
class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 0;

  // Main app screens
  final List<Widget> _screens = [
    HomeScreen(),
    TransferScreen(),
  ];

  // Switch tabs
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_rounded),
            label: 'Transfer',
          ),
        ],
      ),
    );
  }
}
