import 'package:easy_vocab/routes/box_selection.dart';
import 'package:easy_vocab/routes/create_box.dart';
import 'package:easy_vocab/routes/data_protection.dart';
import 'package:easy_vocab/routes/home.dart';
import 'package:easy_vocab/routes/exam.dart';
import 'package:easy_vocab/routes/about.dart';
import 'package:easy_vocab/routes/settings.dart';
import 'package:easy_vocab/routes/train.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String trainPage = '/train';
  static const String examPage = '/exam';
  static const String boxSelectionPage = '/boxSelection';
  static const String createBoxPage = '/createBox';
  static const String settingsPage = '/settings';
  static const String aboutPage = '/about';
  static const String dataProtectionPage = 'dataProtection';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case trainPage:
        return MaterialPageRoute(
          builder: (_) => const TrainPage(),
        );

      case examPage:
        return MaterialPageRoute(
          builder: (_) => const ExamPage(),
        );

      case boxSelectionPage:
        return MaterialPageRoute(
          builder: (_) => const BoxSelectionPage(),
        );

      case createBoxPage:
        return MaterialPageRoute(
          builder: (_) => const CreateBoxPage(),
        );

      case settingsPage:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );

      case aboutPage:
        return MaterialPageRoute(
          builder: (_) => const AboutPage(),
        );

      case dataProtectionPage:
        return MaterialPageRoute(
          builder: (_) => const DataProtectionPage(),
        );

      default:
        throw FormatException("Route not found!");
    }
  }
}
