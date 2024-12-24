import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  // Define el modo de tema actual
  ThemeMode _themeMode;

  // Constructor inicializando el modo de tema
  ThemeManager({bool isDarkMode = false})
      : _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Getter para obtener el modo de tema actual
  ThemeMode get themeMode => _themeMode;

  // Método para alternar entre temas
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifica a los widgets dependientes del cambio
  }

  // Método para establecer un modo de tema explícito
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
