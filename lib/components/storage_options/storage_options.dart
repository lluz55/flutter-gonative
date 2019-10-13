import 'package:flutter/material.dart';
import 'package:gonative_test/components/storage_options/files_tab.dart';
import 'package:gonative_test/components/storage_options/read_from_file_tab.dart';
import 'package:badges/badges.dart';
import 'package:gonative_test/providers/storage_provider.dart';
import 'package:provider/provider.dart';
import 'write_to_file_tab.dart';

class StorageOptions extends StatefulWidget {
  const StorageOptions({
    Key key,
  }) : super(key: key);

  @override
  _StorageOptionsState createState() => _StorageOptionsState();
}

class _StorageOptionsState extends State<StorageOptions>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  double _tabTop = 0.0;
  GlobalKey _tabKey = GlobalKey();

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox render = _tabKey.currentContext.findRenderObject();
      setState(() {
        _tabTop = render.localToGlobal(Offset.zero).dy;
      });
      print(_tabTop);
    });
    super.initState();
  }

  TextStyle _tabTitleStyle() {
    return TextStyle(
      color: Colors.blueGrey[800],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(
              child: Text(
                'Write'.toUpperCase(),
                style: _tabTitleStyle(),
              ),
            ),
            Tab(
              child: Consumer<StorageProvider>(
                builder: (_, prov, __) {
                  return Badge(
                    showBadge: prov.fileModified,
                    toAnimate: true,
                    position: BadgePosition(top: -14.0, right: -16.0),
                    padding: EdgeInsets.all(6.0),
                    badgeContent: Text(
                      '!',
                      style: _badgeStyle,
                    ),
                    child: Text(
                      'Read'.toUpperCase(),
                      style: _tabTitleStyle(),
                    ),
                  );
                },
              ),
            ),
            Tab(
              child: Text(
                'Show Files'.toUpperCase(),
                style: _tabTitleStyle(),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(),
          height: MediaQuery.of(context).size.height - (_tabTop + 8.0),
          child: TabBarView(
            key: _tabKey,
            controller: _controller,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WriteToFileTab(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ReadFromFileTab(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: FileTab(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  final _badgeStyle = TextStyle(
    color: Colors.white,
  );
}
