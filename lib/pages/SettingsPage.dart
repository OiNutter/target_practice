import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  SharedPreferences _prefs;
  TextEditingController _projectilesController;
  TextEditingController _targetsController;

  void initState() {
    super.initState();
    _setupControllers();
  }

  void dispose() {
    _projectilesController.dispose();
    _targetsController.dispose();
    super.dispose();
  }

  void _setupControllers() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      print('PREFS LOADED');
      print(_prefs.getInt('numProjectiles'));
      _projectilesController = TextEditingController
        .fromValue(
          TextEditingValue(
            text: (_prefs.getInt('numProjectiles') ?? 1).toString()
          )
        );
      _targetsController = TextEditingController
        .fromValue(
          TextEditingValue(
            text: (_prefs.getInt('numTargets') ?? 1).toString()
          )
        );
    });
  }

  void _saveSettings() async {
    _prefs.setInt('numProjectiles', int.parse(_projectilesController.text));
    _prefs.setInt('numTargets', int.parse(_targetsController.text));
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
        // Here we take the value from the MySettingsPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:Text(
                          "What's your setup?",
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Number of Projectiles"
                          ),
                          keyboardType: TextInputType.number,
                          controller: _projectilesController,
                          onSubmitted: (String value) {
                            _saveSettings();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Number of Targets"
                          ),
                          keyboardType: TextInputType.number,
                          controller: _targetsController,
                          onSubmitted: (String value) {
                            _saveSettings();
                          }
                        )
                      ),

                      Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveSettings();
          Navigator.pop(context);
        },
        tooltip: 'Save',
        child: Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
