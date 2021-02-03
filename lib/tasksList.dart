import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class tasksList extends ChangeNotifier {
  List<String> _taskList = [];
  List<bool> _taskStatus = [];
  List<String> _taskDescList = [];
  List<String> _taskDateTime = [];
  List<String> _tag = [];

  List<String> _availableTags = [
    'None',
    'Work',
    'Hobby',
    'Leisure',
    'Note',
    'Remind',
    'Important',
  ];

  int selectedIndex = 0;
  changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  _encryptJSON(plainText) {
    final encrypted = encrypter.encryptBytes(plainText, iv: iv);
    return encrypted.bytes;
  }

  _decryptJSON(encText) {
    encrypt.Encrypted en = encrypt.Encrypted(encText);
    return encrypter.decryptBytes(en, iv: iv);
  }

  var taskJSON = new Map<String, dynamic>();
  addtaskValue(String title, String subtitle) {
    _taskList.add(title);
    _taskStatus.add(false);
    _taskDescList.add(subtitle);
    _taskDateTime.add(getCurrentDateTime());
    _tag.add(_availableTags[selectedIndex]);
    selectedIndex = 0;
    writeContent();
    notifyListeners();
  }

  removeTaskValue(int index) {
    _taskList.removeAt(index);
    _taskStatus.removeAt(index);
    _taskDescList.removeAt(index);
    _taskDateTime.removeAt(index);
    _tag.remove(index);
    clearJSON();
    writeContent();
    notifyListeners();
  }

  updateTask(String updatedTask, String updatedDesc, int index) {
    _taskList[index] = updatedTask;
    _taskDescList[index] = updatedDesc;
    _taskDateTime[index] = getCurrentDateTime();
    _tag[index] = _availableTags[selectedIndex];
    selectedIndex = 0;
    notifyListeners();
    clearJSON();
    writeContent();
  }

  removeall() async {
    _taskList = [];
    _taskStatus = [];
    _taskDescList = [];
    _taskDateTime = [];
    _tag = [];
    await clearJSON();
    notifyListeners();
  }

  getCurrentDateTime() {
    var currentDateTime = DateTime.now();
    var formattedDateTime =
        DateFormat.jm().addPattern("\n").add_yMd().format(currentDateTime);
    return formattedDateTime;
  }

  changeStatus(index) {
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
      var jsonString = await file.readAsBytes();
      var data = jsonDecode(utf8.decode(_decryptJSON(jsonString)));
      for (int i = 0; i < data['title'].length; i++) {
        _taskList.add(data["title"][i]);
        _taskStatus.add(data["status"][i]);
        _taskDescList.add(data["description"][i]);
        _taskDateTime.add(data["dateTime"][i]);
        _tag.add(data["tag"][i]);
      }
      notifyListeners();
    } catch (FileSystemException) {
      File file = await _localFile;
      file.create();
    }
  }

  Future writeContent() async {
    taskJSON['title'] = _taskList;
    taskJSON['status'] = _taskStatus;
    taskJSON['description'] = _taskDescList;
    taskJSON['dateTime'] = _taskDateTime;
    taskJSON['tag'] = _tag;
    var serializedMap = _encryptJSON(utf8.encode(jsonEncode(taskJSON)));
    File f = await _localFile;
    await f.writeAsBytes(serializedMap);
  }

  clearJSON() async {
    final path = await _localFile;
    return path.writeAsString("");
  }

  List<String> get getTaskList => _taskList;
  List<bool> get getStatus => _taskStatus;
  List<String> get getTaskDescList => _taskDescList;
  List<String> get getDateTime => _taskDateTime;
  List<String> get getTag => _tag;
  List<String> get getAvailabeTags => _availableTags;
}
