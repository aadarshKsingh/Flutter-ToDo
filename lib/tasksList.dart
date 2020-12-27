import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class tasksList extends ChangeNotifier {
  List<String> _taskList = [];
  List<String> _taskDescList = [];
  List<String> _taskDateTime = [];

  var taskJSON = new Map<String, dynamic>();
  addtaskValue(String title, String subtitle) {
    _taskList.add(title);
    _taskDescList.add(subtitle);
    _taskDateTime.add(getCurrentDateTime());
    taskJSON['title'] = _taskList;
    taskJSON['description'] = _taskDescList;
    taskJSON['dateTime'] = _taskDateTime;
    writeContent();
    notifyListeners();
  }

  removeTaskValue(int index) {
    _taskList.removeAt(index);
    _taskDescList.removeAt(index);
    _taskDateTime.removeAt(index);
    clearJSON();
    taskJSON['title'] = _taskList;
    taskJSON['description'] = _taskDescList;
    taskJSON['dateTime'] = _taskDateTime;
    notifyListeners();
  }

  removeall() async {
    _taskList = [];
    _taskDescList = [];
    _taskDateTime = [];
    await clearJSON();
    notifyListeners();
  }

  getCurrentDateTime() {
    var currentDateTime = DateTime.now();
    var formattedDateTime =
        DateFormat.jm().addPattern("\n").add_yMd().format(currentDateTime);
    return formattedDateTime;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.json');
  }

  Future<void> readContent() async {
    try {
      File file = await _localFile;
      String jsonString = await file.readAsString();
      var data = jsonDecode(jsonString);
      for (int i = 0; i < data['title'].length; i++) {
        _taskList.add(data["title"][i]);
        _taskDescList.add(data["description"][i]);
        _taskDateTime.add(data["dateTime"][i]);
      }
      notifyListeners();
    } catch (FileSystemException) {
      print("tasks.json not found");
    }
  }

  Future<File> writeContent() async {
    final path = await _localFile;
    String serializedMap = jsonEncode(taskJSON);
    return path.writeAsString(serializedMap);
  }

  clearJSON() async {
    final path = await _localFile;
    return path.writeAsString("");
  }

  List<String> get getTaskList => _taskList;
  List<String> get getTaskDescList => _taskDescList;
  List<String> get getDateTime => _taskDateTime;
}
