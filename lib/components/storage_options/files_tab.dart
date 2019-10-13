import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gonative_test/providers/storage_provider.dart';
import 'package:provider/provider.dart';

class FileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<StorageProvider>(context, listen: false).getFiles();
    });
    return Container(child: Consumer<StorageProvider>(
      builder: (context, prov, child) {
        return !prov.filesReady
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Files from /sdcard/".toUpperCase(),
                      style: _headerStyle,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: true,
                      itemCount: prov.files.files.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            prov.files.files[index].filename,
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
      },
    ));
  }

  final _headerStyle = TextStyle(
    color: Colors.blueGrey[400],
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );
}
