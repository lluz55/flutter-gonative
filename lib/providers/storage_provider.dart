import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gonative_test/models/files_model.dart';

class StorageProvider extends ChangeNotifier {
  static const platform = const MethodChannel("example.com/gonative");

  String _fileContent = "";
  FilesModel _files;
  bool filesReady = false;
  bool fileNotExists = false;
  bool fileModified = false;

  FilesModel get files => _files;
  String get fileContent => _fileContent;

  Future<bool> saveToFile(String content) async {
    fileModified = true;
    try {
      var args = Map();
      args["msg"] = content;
      await platform.invokeMethod('storageTest_write', args);
      // TODO: send positive feedback
    } on PlatformException catch (e) {
      // TODO: send error feedback
      print(e);
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> readFromFile() async {
    fileNotExists = false;
    fileModified = false;
    String content;
    try {
      var args = Map();
      content = await platform.invokeMethod('storageTest_read', args);
    } on PlatformException catch (e) {
      if (e.toString().contains("no such file or directory")) {
        fileNotExists = true;
        notifyListeners();
      }
      print(e.toString());
      return false;
    }
    if (content != null) {
      _fileContent = content;
      notifyListeners();
      return true;
    }
  }

  Future<void> getFiles() async {
    String fileJson;
    try {
      var args = Map();
      fileJson = await platform.invokeMethod('storageTest_listFiles', args);
    } on PlatformException catch (e) {
      print(e);
    }
    if (fileJson != null) {
      _files = FilesModel.fromJson(jsonDecode(fileJson));
      filesReady = true;
      notifyListeners();
    }
  }
}
