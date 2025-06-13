import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  static const String _languageKey = 'selected_language';
  
  Locale _currentLocale = const Locale('en');
  
  Locale get currentLocale => _currentLocale;
  
  LanguageProvider() {
    _loadSavedLanguage();
  }
  
  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await _storage.read(key: _languageKey);
    if (savedLanguage != null) {
      _currentLocale = Locale(savedLanguage);
      notifyListeners();
    }
  }
  
  Future<void> setLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await _storage.write(key: _languageKey, value: languageCode);
    notifyListeners();
  }
} 