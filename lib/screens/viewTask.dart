import 'package:flutter/material.dart';
import 'package:letsdoit/screens/editTask.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/utils/saveConfig.dart';

Widget viewTask(
    BuildContext context,
    TextEditingController? _taskController,
    TextEditingController? _descController,
    tasksList value,
    int index,
    saveConfig model_saveConfig,
    tasksList model_tasksList) {
  final _editKey = GlobalKey<FormState>();
  return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_rounded,
          ),
          Center(
            child: Text("Task Details"),
          ),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pop(context);
                _taskController!.text = value.getTaskList[index];
                _descController!.text = value.getTaskDescList[index];
                model_tasksList.selectedIndex = model_tasksList.getAvailabeTags
                    .indexOf(model_tasksList.getTag[index]);
                showDialog(
                    context: context,
                    builder: (context) => editTask(
                        context,
                        _taskController,
                        _descController,
                        value,
                        index,
                        model_saveConfig,
                        model_tasksList));
              })
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text("Task Title       :     "),
                  Flexible(
                      child: Text(
                    value.getTaskList[index],
                    softWrap: true,
                  ))
                ],
              ),
              Row(children: [
                Text('Task Done     :     '),
                Text(value.getStatus[index].toString()),
              ]),
              Row(children: [
                Text('Description   :   '),
                value.getTaskDescList[index].isEmpty
                    ? Text("NA")
                    : Flexible(
                        child: Text(
                          value.getTaskDescList[index],
                          softWrap: true,
                        ),
                      )
              ]),
            ],
          ),
        )
      ]);
}
