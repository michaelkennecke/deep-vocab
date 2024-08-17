import 'package:vocablix/models/setting_page.dart';
import 'package:vocablix/static_content/setting_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            //color: Colors.amberAccent,
            height: 160,
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: SettingPages.settingPages.length,
              itemBuilder: (BuildContext context, int index) {
                var settingPage = SettingPages.settingPages[index];
                if (index == SettingPages.settingPages.length - 1) {
                  return Container();
                } else {
                  return Container(
                    child: buildListItems(settingPage, index, context),
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          Center(child: Text('App version: 0.1.0')),
        ],
      ),
    );
  }

  Widget buildListItems(SettingPage settingPage, index, context) {
    return GestureDetector(
      onTap: () => {
        settingPage.settingPageId == 0
            ? showLicensePage(context: context)
            : Navigator.pushNamed(context, settingPage.routeLink)
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: [
                Icon(settingPage.icon),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(settingPage.title),
                ),
              ],
            ),
          ),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
