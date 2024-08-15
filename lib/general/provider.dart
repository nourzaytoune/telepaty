import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _selectedCategory = 'Beach';
  bool _showAllCategories = false;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  bool get showAllCategories => _showAllCategories;

  set showAllCategories(bool showAll) {
    _showAllCategories = showAll;
    notifyListeners();
  }

  List<String> getCategories() {
    return [
      'Nature',
      'Beach',
      'Gastronomy',
      'City and Culture',
      'Sun and Beach'
    ];
  }
}
class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
class LocaleNotifier extends ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}


/*class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}*/