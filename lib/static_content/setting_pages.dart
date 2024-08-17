import 'package:vocablix/models/setting_page.dart';
import 'package:vocablix/routes.dart';
import 'package:flutter/material.dart';

class SettingPages {
  static List<SettingPage> settingPages = [
    SettingPage(0, 'Open Source Libraries', Icons.library_books,
        RouteGenerator.aboutPage),
    SettingPage(1, 'Data Protection', Icons.security,
        RouteGenerator.dataProtectionPage),
    SettingPage(2, 'Contact information', Icons.info, RouteGenerator.aboutPage),
    SettingPage(3, ' ', Icons.remove, RouteGenerator.aboutPage),
  ];
}
