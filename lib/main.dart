import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  getPermission();
}

void getPermission() async {
  // final perm = PermissionHandler();
  // perm.requestPermissions([PermissionGroup.storage, .])
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _serverStarted = false;

  static const platform = const MethodChannel("example.com/gonative");

  static Future<void> _startServer() async {
    try {
      var args = Map();
      platform.invokeMethod("Server_run", args);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _serverStarted
                ? Text(
                    'Server listening at port 8081\n Go to localhost:8081/ping')
                : Text(
                    'Server stoped',
                  ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(height: 50.0),
            RaisedButton(
              onPressed: _serverStarted
                  ? null
                  : () async {
                      _startServer();
                      _serverStarted = true;
                    },
              child: Text('Start Server'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
