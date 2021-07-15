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
  return SimpleDialog(
    titlePadding: const EdgeInsets.only(top: 10, left: 15, right: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Text(
            "Task Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            splashRadius: 10,
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: Icon(
              Icons.edit,
              size: 25,
            ),
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
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(0.2),
            2: FlexColumnWidth(1)
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Text("Task Title"),
                Text(':'),
                Text(
                  value.getTaskList[index],
                  softWrap: true,
                )
              ],
            ),
            TableRow(children: [
              Text('Task Done'),
              Text(':'),
              Text(value.getStatus[index].toString()),
            ]),
            TableRow(children: [
              Text('Description'),
              Text(':'),
              value.getTaskDescList[index].isEmpty
                  ? Text("NA")
                  : Text(
                      value.getTaskDescList[index],
                      softWrap: true,
                    )
            ]),
          ],
        ),
      ),
    ],
  );
}
