import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'welcome': 'Welcome',
      'selectLanguage': 'Select Language',
      'english': 'English',
      'vietnamese': 'Vietnamese',
      'goToPdfDemo': 'Go to PDF DEMO',
      'all': 'All',
      'assignedToMe': 'Assigned to me',
      'employeeList': 'Employee List',
    },
    'vi': {
      'welcome': 'Xin chào',
      'selectLanguage': 'Chọn ngôn ngữ',
      'english': 'Tiếng Anh',
      'vietnamese': 'Tiếng Việt',
      'goToPdfDemo': 'Đến trang PDF DEMO',
      'all': 'Tất cả',
      'assignedToMe': 'Gắn cho tôi',
      'employeeList': 'Danh sách nhân viên',
    },
  };

  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get selectLanguage =>
      _localizedValues[locale.languageCode]!['selectLanguage']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get vietnamese =>
      _localizedValues[locale.languageCode]!['vietnamese']!;
  String get goToPdfDemo =>
      _localizedValues[locale.languageCode]!['goToPdfDemo']!;
  String get all => _localizedValues[locale.languageCode]!['all']!;
  String get assignedToMe =>
      _localizedValues[locale.languageCode]!['assignedToMe']!;
  String get employeeList =>
      _localizedValues[locale.languageCode]!['employeeList']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
