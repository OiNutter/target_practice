import 'package:flutter/material.dart';

// Utils
import './utils/theme.dart';

// Pages
import './pages/HomePage.dart';

void main() {
  runApp(TargetPractice());
}

class TargetPractice extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Target Practice',
      theme: appTheme,
      home: HomePage(title: ''),
    );
  }
}
