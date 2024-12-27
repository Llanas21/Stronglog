import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'package:stronglog/domain/models/workout_model.dart';
import 'package:stronglog/firebase_options.dart';
import 'package:stronglog/ui/screens/detailed_workout_screen.dart';
import 'package:stronglog/ui/screens/home_screen.dart';
import 'package:stronglog/ui/screens/login_screen.dart';
import 'package:stronglog/ui/screens/workouts_screen.dart';
import 'package:stronglog/ui/theme/theme_constants.dart';
import 'package:stronglog/ui/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: DetailedWorkoutScreen(
        workout: Workout(
            id: "ypF6gMJM6D82d4EJHRvq", name: "Pecho & Trícep", day: "Monday"),
      ),
    );
  }
}
