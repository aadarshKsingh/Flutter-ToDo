import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class tasksList extends ChangeNotifier {
  List<String> _taskList = ["sample task"];
  List<String> _taskDescList = ["desc goes here"];

  addtaskValue(String title, String subtitle) {
    _taskList.add(title);
    _taskDescList.add(subtitle);
    notifyListeners();
  }

  removetaskValue(int index, direction) {
    _taskList.removeAt(index);
    _taskDescList.removeAt(index);
    notifyListeners();
  }

  removeall() {
    _taskList = [];
    _taskDescList = [];
    notifyListeners();
  }

  List<String> get getTaskList => _taskList;
  List<String> get getTaskDescList => _taskDescList;
}
