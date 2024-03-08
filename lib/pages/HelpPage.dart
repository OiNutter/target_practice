import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHelpPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "General",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Barton is intended to give you some different training " +
                  "exercises when throwing knives or axes, or even shooting arrows " +
                  "or guns. These exercises will help work on your aim, preventing " +
                  "muscle complacency and helping spread wear around the target."
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "To get started first go to Settings and enter the number of " +
                  "projectiles you use in one session and the number of targets or " +
                  "target areas you have. The app will then use those to generate " +
                  "some random sequences for you to try."
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "Targets",
                  style: Theme.of(context).textTheme.headline4
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Targets will generate a random selection of targets, one per " +
                  "projectile. The goal is to hit these all in one set, so for " +
                  "instance, if I had 3 knives I would be given 3 targets to hit " +
                  "and would try and hit them all in 3 throws. You can choose to " +
                  "hit them in any order or challenge yourself and try and get " +
                  "them in the order given."
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Tap a target to mark it as completed, once all targets are " +
                  "completed a new set will be generated, or hit the refresh button " +
                  "to get a new set."
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "Sequence",
                  style: Theme.of(context).textTheme.headline4
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Sequence will give you one target at a time in a randomly " +
                  "generated sequence. Tap the target to mark it as completed " +
                  "and get your next target. The sequence will continue to " +
                  "generate indefinitely so keep going as long as you want."
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "Patterns",
                  style: Theme.of(context).textTheme.headline4
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Patterns is designed for working round a single target. " +
                  "Rather than being given a number for a target you'll be " +
                  "given an area to hit. The app will choose a random pattern " +
                  "and move you round the board according to that pattern. Each " +
                  "pattern will reverse itself so you'll end up back where you " +
                  "started before a new pattern is chosen. Tap the target to " +
                  "mark it as completed."
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
