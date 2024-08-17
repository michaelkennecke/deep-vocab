import 'package:vocablix/routes.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer();

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final List<String> _routes = [
    RouteGenerator.homePage,
    RouteGenerator.trainPage,
    RouteGenerator.examPage,
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      return;
    } else {
      setState(() {
        Navigator.of(context)?.pushNamed(_routes.elementAt(index));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.create),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school), //model_training
          label: "Train",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: "Test",
        ),
      ],
      onTap: _onItemTapped,
      iconSize: 30,
      selectedItemColor: const Color(0xFFB81d4fa),
    );
  }
}
