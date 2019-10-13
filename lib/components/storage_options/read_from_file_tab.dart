import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gonative_test/providers/storage_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ReadFromFileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final prov = Provider.of<StorageProvider>(context, listen: false);
      if (prov.fileModified) prov.readFromFile();
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Consumer<StorageProvider>(
          builder: (context, storageProvider, child) {
            return Row(
              children: <Widget>[
                storageProvider.fileContent == "" &&
                        !storageProvider.fileNotExists
                    ? Text(
                        'Click bellow to read the file',
                        style: _labelStyle,
                      )
                    : SizedBox(),
                storageProvider.fileNotExists
                    ? RichText(
                        text: TextSpan(
                            text: " File ",
                            style: _labelStyle,
                            children: [
                              TextSpan(text: " test.txt ", style: _errorStyle),
                              TextSpan(text: " doesn't exist"),
                            ]),
                      )
                    : storageProvider.fileContent != ""
                        ? Container(
                            color: Colors.grey[200],
                            width: MediaQuery.of(context).size.width - 50.0,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  storageProvider.fileContent,
                                  style: _contentStyle,
                                )),
                          )
                        : SizedBox()
              ],
            );
          },
        ),
        RaisedButton(
          onPressed: () async {
            final readResult =
                await Provider.of<StorageProvider>(context, listen: false)
                    .readFromFile();
            // TODO: check result before notifying
            Toast.show("File loaded successfully", context);
          },
          color: Colors.blueGrey[400],
          textColor: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.save),
              SizedBox(width: 6.0),
              Text('Read From File'),
            ],
          ),
        )
      ],
    );
  }

  final _labelStyle = TextStyle(
    color: Colors.blueGrey[600],
    fontSize: 16.0,
  );

  final _errorStyle = TextStyle(
    color: Colors.red[600],
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );

  final _contentStyle = TextStyle(
    fontStyle: FontStyle.italic,
    color: Colors.blueGrey[600],
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );
}
