import 'package:flutter/material.dart';
import 'package:stronglog/ui/screens/home_screen.dart';
import 'package:stronglog/ui/theme/theme_constants.dart';
import 'package:stronglog/ui/theme/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stronglog',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: HomeScreen(),
    );
  }
}
