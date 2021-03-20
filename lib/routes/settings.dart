import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Source Libraries"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Icon(
              Icons.engineering,
              size: 70,
            ),
            Text(
              "Comming Soon!",
            ),
          ],
        ),
      ),
    );
  }
}
