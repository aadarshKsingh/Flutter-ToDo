import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class tasksList extends ChangeNotifier {
  List<String> _taskList = [];
  List<String> _taskDescList = [];
  List<String> _taskDateTime = [];

  getCurrentDateTime() {
    var currentDateTime = DateTime.now();
    var formattedDateTime =
        DateFormat.jm().addPattern("\n").add_yMd().format(currentDateTime);
    return formattedDateTime;
  }

  addtaskValue(String title, String subtitle) {
    _taskList.add(title);
    _taskDescList.add(subtitle);
    _taskDateTime.add(getCurrentDateTime());
    notifyListeners();
  }

  removetaskValue(int index, direction) {
    _taskList.removeAt(index);
    _taskDescList.removeAt(index);
    _taskDateTime.removeAt(index);
    notifyListeners();
  }

  removeall() {
    _taskList = [];
    _taskDescList = [];
    _taskDescList = [];
    notifyListeners();
  }

  List<String> get getTaskList => _taskList;
  List<String> get getTaskDescList => _taskDescList;
  List<String> get getDateTime => _taskDateTime;
}
