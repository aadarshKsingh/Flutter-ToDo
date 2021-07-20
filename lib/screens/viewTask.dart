import 'package:flutter/material.dart';
import 'package:letsdoit/screens/editTask.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/utils/saveConfig.dart';

Widget viewTask(
    BuildContext context,
    TextEditingController? _taskController,
    TextEditingController? _descController,
    TasksList value,
    int index,
    SaveConfig modelSaveConfig,
    TasksList modelTasksList) {
  return SimpleDialog(
    titlePadding: const EdgeInsets.only(top: 10, left: 15, right: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Center(
          child: Text(
            "Task Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            splashRadius: 10,
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: const Icon(
              Icons.edit,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
              _taskController!.text = value.getTaskList[index];
              _descController!.text = value.getTaskDescList[index];
              modelTasksList.selectedIndex = modelTasksList.getAvailabeTags
                  .indexOf(modelTasksList.getTag[index]);
              showDialog(
                  context: context,
                  builder: (context) => editTask(
                      context,
                      _taskController,
                      _descController,
                      value,
                      index,
                      modelSaveConfig,
                      modelTasksList));
            })
      ],
    ),
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(0.2),
            2: FlexColumnWidth(1)
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                const Text("Task Title"),
                const Text(':'),
                Text(
                  value.getTaskList[index],
                  softWrap: true,
                )
              ],
            ),
            TableRow(children: [
              const Text('Task Done'),
              const Text(':'),
              Text(value.getStatus[index].toString()),
            ]),
            TableRow(children: [
              const Text('Description'),
              const Text(':'),
              value.getTaskDescList[index].isEmpty
                  ? const Text("NA")
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
