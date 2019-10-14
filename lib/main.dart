import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class HandleNative {
  static const platform = const MethodChannel('example.com/gonative');
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Create SQLite DataBase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _granted = false;
  bool _existsDB = false;

  @override
  initState() {
    Future.delayed(Duration(milliseconds: 250), () async {
      _granted = await _grantPermission();
      setState(() {});
    });
    super.initState();
  }

  Future<bool> _grantPermission() async {
    final storagePerm = PermissionHandler();
    bool isShown = await PermissionHandler()
        .shouldShowRequestPermissionRationale(PermissionGroup.contacts);
    if (!isShown) {
      final result =
          await storagePerm.requestPermissions([PermissionGroup.storage]);
      if (result[PermissionGroup.storage] == PermissionStatus.granted) {
        try {
          await HandleNative.platform.invokeMethod("db_createDir");
        } catch (e) {
          print(e);
        }
        setState(() {
          _granted = true;
        });
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  Future<void> _createDB(BuildContext context) async {
    await _checkExistsDB();
    if (_existsDB) {
      Toast.show('DB already exists', context);
      return;
    }

    final granted = await _grantPermission();
    if (granted) {
      try {
        var args = Map();
        await HandleNative.platform.invokeMethod("db_opendb", args);
      } on PlatformException catch (e) {
        print(e);
      }
      await _checkExistsDB();
      if (_existsDB) {
        Toast.show('DB created successfully', context);
      }
    } else {}
  }

  Future<void> _checkExistsDB() async {
    try {
      _existsDB = await HandleNative.platform.invokeMethod('db_existsDB');
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !_granted
                ? Text('Grant Storage Permission', style: _infoStyle)
                : Text('Click on the FAB to create DB', style: _infoStyle),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createDB(context),
        tooltip: 'Open DB',
        child: Icon(
          _granted ? Icons.save_alt : Icons.report_problem,
          color: Colors.white,
        ),
      ),
    );
  }

  final _infoStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w300,
  );
}
