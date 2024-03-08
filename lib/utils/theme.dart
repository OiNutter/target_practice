import 'package:flutter/material.dart';

ButtonThemeData buttonTheme = ThemeData
  .dark()
  .buttonTheme
  .copyWith(
    buttonColor: Colors.blue
  );

FloatingActionButtonThemeData floatingButtonTheme = ThemeData
  .dark()
  .floatingActionButtonTheme
  .copyWith(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  );

ThemeData appTheme = ThemeData(
  // This is the theme of your application.
  //
  // Try running your application with "flutter run". You'll see the
  // application has a blue toolbar. Then, without quitting the app, try
  // changing the primarySwatch below to Colors.green and then invoke
  // "hot reload" (press "r" in the console where you ran "flutter run",
  // or simply save your changes to "hot reload" in a Flutter IDE).
  // Notice that the counter didn't reset back to zero; the application
  // is not restarted.
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  buttonTheme: buttonTheme,
  floatingActionButtonTheme: floatingButtonTheme,
  // This makes the visual density adapt to the platform that you run
  // the app on. For desktop platforms, the controls will be smaller and
  // closer together (more dense) than on mobile platforms.
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
