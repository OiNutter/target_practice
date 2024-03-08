import 'package:flutter/material.dart';
import './TargetsPage.dart';
import './SequencePage.dart';
import './PatternsPage.dart';

import '../utils/SubMenu.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _pages = {
      "Targets": TargetsPage(title: 'Targets'),
      "Sequence": SequencePage(title: 'Sequence'),
      "Patterns": PatternsPage(title: 'Patterns'),
  };

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    List<Widget> _menuButtons = new List.generate(_pages.keys.length, (int i) {
      var key = _pages.keys.elementAt(i);
      var route = _pages[key];

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => route),
              );
            },
            padding: const EdgeInsets.all(15.0),
            child: Text(
              key,
              style: Theme.of(context).textTheme.headline4
            ),
          )
        )
      );
    });

    Orientation orientation = MediaQuery.of(context).orientation;

    var _logoWidgets;
    EdgeInsets _menuPadding;
    EdgeInsets _logoPadding;

    if (orientation == Orientation.landscape) {
      _menuPadding = EdgeInsets.all(15.0);
      _logoPadding = EdgeInsets.symmetric(vertical: 15.0, horizontal: 300.0);
      _logoWidgets = <Widget>[
        Expanded(
          child: Image.asset("assets/logo-text.png"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0, 30.0, 0),
          child: Image.asset("assets/icon.png", height: 75.0),
        ),
      ];
    } else {
      _menuPadding = EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0);
      _logoPadding = EdgeInsets.symmetric(vertical: 15.0, horizontal: 120.0);
      _logoWidgets = <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset("assets/icon.png", height: 100.0),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
          child: Image.asset("assets/logo-text.png"),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: SubMenu.getWidgets(context),
      ),
      body: Center(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: _logoPadding,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: (orientation == Orientation.portrait) ? Axis.vertical : Axis.horizontal,
                children: _logoWidgets,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
              child: Text(
                "How do you want to practice?",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: _menuPadding,
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction: (orientation == Orientation.portrait) ? Axis.vertical : Axis.horizontal,
                  children: _menuButtons,
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
