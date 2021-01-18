import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dark = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  accentColor: Colors.pink,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final light = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.pink,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.green,
  accentIconTheme: IconThemeData(color: Colors.pink),
  dividerColor: Colors.white54,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
