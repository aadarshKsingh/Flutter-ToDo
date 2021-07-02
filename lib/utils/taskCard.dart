import 'package:flutter/material.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/screens/editTask.dart';

Widget taskCard(
    BuildContext context,
    saveConfig model_saveConfig,
    tasksList model_tasksList,
    int index,
    tasksList value,
    TextEditingController? _descController,
    TextEditingController? _taskController) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: ListTile(
      tileColor: model_saveConfig.getAccent().withOpacity(0.3),
      contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      leading: IconButton(
          icon: model_tasksList.getStatus[index] == true
              ? Icon(
                  Icons.check_circle_rounded,
                  size: 27,
                  color: model_saveConfig.getAccent(),
                )
              : Icon(
                  Icons.check_circle_outline_rounded,
                  size: 27,
                ),
          onPressed: () => model_tasksList.changeStatus(index)),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => editTask(context, _taskController, _descController,
                value, index, model_saveConfig, model_tasksList));
      },
      trailing: Card(
          elevation: 0,
          margin: EdgeInsets.only(right: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: model_saveConfig.getAccent().withOpacity(0.25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "\t" + value.getDateTime[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                      color: Color(0xFF1C1C1C)),
                ),
              ),
            ],
          )),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, left: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                value.getTaskList[index],
                softWrap: true,
                style: TextStyle(
                    fontSize: 25,
                    decoration: value.getStatus[index]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 3,
                    decorationColor: model_saveConfig.getAccent(),
                    decorationStyle: TextDecorationStyle.solid),
              ),
            ),
            value.getTag[index] == 'None'
                ? const SizedBox()
                : Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                model_saveConfig.getAccent().withOpacity(0.6),
                            width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(bottom: 0, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: Text(
                      model_tasksList.getTag[index],
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
          ],
        ),
      ),
    ),
  );
}
