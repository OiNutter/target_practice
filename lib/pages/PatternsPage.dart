import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../utils/SubMenu.dart';

class PatternsPage extends StatefulWidget {
  PatternsPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PatternsPageState createState() => _PatternsPageState();
}

class _PatternsPageState extends State<PatternsPage> {

  String _patternName;
  var _sequence = [];
  var _shortcodes = {
    "T": "Top",
    "L": "Left",
    "R": "Right",
    "B": "Bottom",
    "M": "Middle",
  };

  var _patterns = {
    "Vertical Runs": ["TL", "L", "BL", "T", "M", "B", "TR", "R", "BR"],
    "Horizontal Runs": ["TL", "T", "TR", "L", "M", "R", "BL", "B", "BR"],
    "Vertical Zig Zag": ["TL", "L", "BL", "B", "M", "T", "TR", "R", "BR"],
    "Horizontal Zig Zag": ["TL", "T", "TR", "R", "M", "L", "BL", "B", "BR"],
    "Descending Diagonals": ["TL", "T", "L", "TR", "M", "BL", "R", "B", "BR"],
    "Ascending Diagonals": ["BL", "B", "L", "BR", "M", "TL", "R", "T", "TR"],
  };

  void _generateSequence() {
    setState(() {
      final _random = new Random();
      _sequence = [];

      int choice = _random.nextInt(_patterns.keys.length);
      String key = _patterns.keys.elementAt(choice);

      while (key == _patternName) {
        choice = _random.nextInt(_patterns.keys.length);
        key = _patterns.keys.elementAt(choice);
      }

      _patternName = key;
      var _pattern = _patterns[_patternName];
      var _reversed = _pattern
        .reversed
        .toList()
        .getRange(1, _pattern.length)
        .toList();
      print (_pattern);
      print (_reversed);
      _sequence = _pattern + _reversed;

    });
  }

  String _getName(String code) {

    var _bits = code.split('');
    var _areas = [];

    _bits.forEach((String char) {

      if (_shortcodes.keys.contains(char))
        _areas.add(_shortcodes[char]);

    });

    return _areas.join('\n');

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _generateSequence();
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
    String _formattedPattern = _patternName.replaceFirst(' ', '\n');

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          _formattedPattern,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Text(
                        'Your next area is:',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: SizedBox.expand(
                    child: RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          _sequence.removeAt(0);
                          print(_sequence.length);
                          if (_sequence.length <= 0)
                            _generateSequence();
                        });
                      },
                      elevation: 2.0,
                      fillColor: Colors.blue,
                      child: Text(
                        _getName(_sequence[0]),
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateSequence,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
