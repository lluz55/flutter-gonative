import 'package:flutter/material.dart';
import 'package:gonative_test/providers/storage_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class WriteToFileTab extends StatefulWidget {
  const WriteToFileTab({
    Key key,
  }) : super(key: key);

  @override
  _WriteToFileTabState createState() => _WriteToFileTabState();
}

class _WriteToFileTabState extends State<WriteToFileTab> {
  TextEditingController _controller = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextField(
          controller: _controller,
          // keyboardType: TextInputType.multiline,
          // maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Write something',
            border: OutlineInputBorder(),
            fillColor: Colors.blueGrey[700],
          ),
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        RaisedButton(
          onPressed: _controller.text != ""
              ? () async {
                  final saveToFile =
                      await Provider.of<StorageProvider>(context, listen: false)
                          .saveToFile(_controller.value.text);
                  // TODO: check result before notifying
                  Toast.show("File saved successfully", context);
                  _controller.text = "";
                  setState(() {});
                }
              : null,
          color: Colors.blueGrey[400],
          textColor: Colors.white,
          disabledColor: Colors.grey[300],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.save),
              SizedBox(width: 6.0),
              Text('Write to File'),
            ],
          ),
        )
      ],
    );
  }
}
