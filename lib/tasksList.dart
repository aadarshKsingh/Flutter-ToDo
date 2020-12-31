import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class tasksList extends ChangeNotifier {
  List<String> _taskList = [];
  List<bool> _taskStatus = [];
  List<String> _taskDescList = [];
  List<String> _taskDateTime = [];

  var taskJSON = new Map<String, dynamic>();
  addtaskValue(String title, String subtitle) {
    _taskList.add(title);
    _taskStatus.add(false);
    _taskDescList.add(subtitle);
    _taskDateTime.add(getCurrentDateTime());
    writeContent();
    notifyListeners();
  }

  removeTaskValue(int index) {
    _taskList.removeAt(index);
    _taskStatus.removeAt(index);
    _taskDescList.removeAt(index);
    _taskDateTime.removeAt(index);
    clearJSON();
    writeContent();
    notifyListeners();
  }

  removeall() async {
    _taskList = [];
    _taskStatus = [];
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

  changeStatus(value, index) {
    _taskStatus[index] = !_taskStatus[index];
    clearJSON();
    writeContent();
    notifyListeners();
  }

  allTasksDone() {
    if (_taskStatus.contains(false))
      for (var i = 0; i < _taskList.length; i++) {
        _taskStatus[i] = true;
      }
    else if (_taskStatus.contains(true))
      for (var i = 0; i < _taskList.length; i++) {
        _taskStatus[i] = false;
      }

    clearJSON();
    writeContent();
    notifyListeners();
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
        _taskStatus.add(data["status"][i]);
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
    taskJSON['title'] = _taskList;
    taskJSON['status'] = _taskStatus;
    taskJSON['description'] = _taskDescList;
    taskJSON['dateTime'] = _taskDateTime;
    String serializedMap = jsonEncode(taskJSON);
    return path.writeAsString(serializedMap);
  }

  clearJSON() async {
    final path = await _localFile;
    return path.writeAsString("");
  }

  List<String> get getTaskList => _taskList;
  List<bool> get getStatus => _taskStatus;
  List<String> get getTaskDescList => _taskDescList;
  List<String> get getDateTime => _taskDateTime;
}
