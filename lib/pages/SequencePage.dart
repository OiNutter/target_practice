import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../utils/SubMenu.dart';

class SequencePage extends StatefulWidget {
  SequencePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SequencePageState createState() => _SequencePageState();
}

class _SequencePageState extends State<SequencePage> {

  int _projectiles;
  int _numTargets;
  var _targets = [];

  SharedPreferences _prefs;
  void _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _projectiles = _prefs.getInt('numProjectiles') ?? 1;
    _numTargets = _prefs.getInt('numTargets') ?? 1;
    _generateSequence();
  }

  void _generateSequence() {
    setState(() {
      final _random = new Random();

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      while (_targets.length < _numTargets) {
        int target = _random.nextInt(_numTargets) + 1;

        int start = max(0, _targets.length - _projectiles -1);
        print(start);
        while (_targets.getRange(start, _targets.length).contains(target)) {
          target = _random.nextInt(_numTargets) + 1;
        }

        _targets.add(target);
      }

      print(_targets);

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadSettings();
  }

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: SubMenu.getWidgets(context),
      ),
      body: SafeArea(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Flex(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            direction: (orientation == Orientation.portrait) ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Your next target is:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: SizedBox.expand(
                    child: RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          _targets.removeAt(0);
                          _generateSequence();
                        });
                      },
                      elevation: 2.0,
                      fillColor: Colors.blue,
                      child: Text(
                        _targets[0].toString(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      shape: CircleBorder(),
                      //constraints: const BoxConstraints(minWidth: 200.0, minHeight: 200.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
