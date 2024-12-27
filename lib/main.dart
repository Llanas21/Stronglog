import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'package:provider/provider.dart';
import 'package:stronglog/domain/models/workout_model.dart';
import 'package:stronglog/firebase_options.dart';
import 'package:stronglog/ui/providers/add_exercise_provider.dart';
import 'package:stronglog/ui/screens/add_exercise_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddExerciseProvider>(
            create: (context) => AddExerciseProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Stronglog',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeManager.themeMode,
          home: HomeScreen()),
    );
  }
}
