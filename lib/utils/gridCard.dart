import 'package:flutter/material.dart';
import 'package:letsdoit/screens/editTask.dart';

Widget gridCard(context, model_saveConfig, model_tasksList, index, value,
    _descController, _taskController) {
  return ListTileTheme(
    tileColor: model_saveConfig.getAccent().withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model_tasksList.getTaskList[index],
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        decoration: model_tasksList.getStatus[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 3,
                        decorationColor: model_saveConfig.getAccent(),
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                  IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.all(0),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => editTask(
                          context,
                          _taskController,
                          _descController,
                          value,
                          index,
                          model_saveConfig,
                          model_tasksList),
                    ),
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          value.getTag[index] == 'None'
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: model_saveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 5, right: 5),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Text(
                    model_tasksList.getTag[index],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
          const SizedBox(height: 5),
          model_tasksList.getTaskDescList[index] == ''
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    model_tasksList.getTaskDescList[index],
                    style: TextStyle(
                        decoration: model_tasksList.getStatus[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 3,
                        decorationColor: model_saveConfig.getAccent(),
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.bottomLeft,
                    icon: model_tasksList.getStatus[index] == true
                        ? Icon(
                            Icons.check_circle_rounded,
                            size: 30,
                            color: model_saveConfig.getAccent(),
                          )
                        : Icon(
                            Icons.check_circle_outline_rounded,
                            size: 30,
                          ),
                    onPressed: () => model_tasksList.changeStatus(index)),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('\t' + model_tasksList.getDateTime[index],
                      style: TextStyle(fontSize: 13)),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
