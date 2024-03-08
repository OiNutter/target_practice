import 'package:flutter/material.dart';
import '../pages/SettingsPage.dart';
import '../pages/HelpPage.dart';

class SubMenu {
  static var submenu = {
    "Help": HelpPage(title: 'Help'),
    "Settings": SettingsPage(title: 'Settings'),
  };

  static void navigate(String choice, BuildContext context) {
    // Causes the app to rebuild with the new _selectedChoice.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => submenu[choice]),
    );
  }

  static List<Widget> getWidgets(BuildContext context) {
    return <Widget>[
      // action button
      IconButton(
        icon: Icon(Icons.help),
        onPressed: () {
          navigate("Help", context);
        },
      ),
      // action button
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          navigate("Settings", context);
        },
      ),
    ];
  }
}
