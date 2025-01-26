import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    subtitleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
    iconColor: Colors.black,
  ),
  snackBarTheme: const SnackBarThemeData(
    actionTextColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.grey,
    brightness: Brightness.light, // Asegura que el esquema es consistente
  ),
  useMaterial3: false, // Actualizado a Material 3
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: Colors.grey[400],
      fontSize: 16,
    ),
    labelSmall: TextStyle(
      color: Colors.grey[400],
      fontSize: 12,
    ),
    bodyMedium: const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    bodySmall: const TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.black; // Color cuando está activo
      }
      return Colors.white; // Color cuando está inactivo
    }),
  ),
  checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(Colors.white),
      checkColor: MaterialStateProperty.all<Color>(Colors.black)),
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
    border:
        const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2.0)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2.0),
    ),
  ),
  chipTheme: const ChipThemeData(
    labelStyle: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData();
