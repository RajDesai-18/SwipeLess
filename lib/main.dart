// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe_less/widget/history_screen.dart';
import 'package:swipe_less/widget/home_screen_content.dart';
import 'package:swipe_less/widget/settings_screen.dart';

void main() {
  runApp(AppUsageTracker());
}

class AppUsageTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Usage Tracker',
      theme: ThemeData(
        useMaterial3: true, // Enable Material Design 3
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 14, 10, 202)),
      ),
      darkTheme: ThemeData.dark(), // Option for dark mode
      themeMode:
          ThemeMode.dark, // Automatically switch theme based on device settings
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('com.example.swipe_less/usage');
  String appUsageTime = 'Unknown';
  int _selectedIndex = 0;

  // List of screens for bottom navigation
  static final List<Widget> _screens = <Widget>[
    HomeScreenContent(),
    SettingsScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> getAppUsageTime() async {
    try {
      final int usageTime = await platform
          .invokeMethod('getUsageStats', {'appName': 'com.gmail.android'});
      setState(() {
        appUsageTime = (usageTime / (1000 * 60))
            .toStringAsFixed(2); // Convert milliseconds to minutes
      });
    } on PlatformException catch (e) {
      setState(() {
        appUsageTime = "Failed to get usage time: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Tracker'),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
