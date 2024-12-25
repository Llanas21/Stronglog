import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white,
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
  useMaterial3: true, // Actualizado a Material 3
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
      color: Colors.grey[600],
      fontSize: 16,
    ),
    labelSmall: TextStyle(
      color: Colors.grey[600],
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

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.black; // Color cuando está activo
      }
      return Colors.white; // Color cuando está inactivo
    }),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData();
