import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact information'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Michael Kennecke'),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  'mkennecke@icloud.com',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
