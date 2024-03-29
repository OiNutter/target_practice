import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:async';

import '../utils/SubMenu.dart';

class TargetsPage extends StatefulWidget {
  TargetsPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TargetsPageState createState() => _TargetsPageState();
}

class _TargetsPageState extends State<TargetsPage> {

  int _projectiles;
  int _numTargets;
  var _targets = [];
  var _hits = [];

  SharedPreferences _prefs;
  void _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _projectiles = _prefs.getInt('numProjectiles') ?? 1;
    _numTargets = _prefs.getInt('numTargets') ?? 1;
    _generateSequence();
  }

  void _generateSequence() {

    setState(() {
      // reset targets list
      _targets = [];
      _hits = [];

      final _random = new Random();

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      for (int i = 0; i < _projectiles; i++) {
        int target = _random.nextInt(_numTargets) + 1;

        while (_targets.contains(target)) {
          target = _random.nextInt(_numTargets) + 1;
        }

        _targets.add(target);

        if (_targets.length == _numTargets)
          break;
      }

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

    List<Widget> _targetLabels = new List.generate(_targets.length, (int i) {
      var target = _targets.elementAt(i);

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: RawMaterialButton(
          onPressed: () {
            setState(() {
              if (!_hits.contains(target))
                _hits.add(target);
            });
          },
          elevation: 2.0,
          fillColor: _hits.contains(target) ? Colors.green : Colors.blue,
          child: Text(
            target.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
          shape: CircleBorder(),
          constraints: const BoxConstraints(minWidth: 150.0, minHeight: 150.0),
        ),
      );
    });

    var future = new Future.delayed(const Duration(seconds: 5), () {
      if (_hits.length >= 3)
        _generateSequence();
    });

    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: SubMenu.getWidgets(context),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth,
                ),
                child: IntrinsicHeight(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
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
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                        child:Text(
                          'Your targets are:',
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ),
                      Expanded (
                        child: Column(
                          mainAxisAlignment: (orientation == Orientation.portrait) ? MainAxisAlignment.center : MainAxisAlignment.start,
                          children: <Widget>[
                            Padding (
                              padding:const EdgeInsets.all(15.0),
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                children: _targetLabels
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateSequence,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
