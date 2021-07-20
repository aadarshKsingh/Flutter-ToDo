import 'package:flutter/material.dart';
import 'package:letsdoit/screens/editTask.dart';

Widget gridCard(context, modelSaveConfig, modelTasksList, index, value,
    _descController, _taskController) {
  return ListTileTheme(
    tileColor: modelSaveConfig.getAccent().withOpacity(0.3),
    shape: const RoundedRectangleBorder(
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
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      modelTasksList.getTaskList[index],
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration: modelTasksList.getStatus[index]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 3,
                          decorationColor: modelSaveConfig.getAccent(),
                          decorationStyle: TextDecorationStyle.solid),
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(0),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => editTask(
                          context,
                          _taskController,
                          _descController,
                          value,
                          index,
                          modelSaveConfig,
                          modelTasksList),
                    ),
                    icon: const Icon(
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
                          color: modelSaveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(top: 5, right: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Text(
                    modelTasksList.getTag[index],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
          const SizedBox(height: 5),
          modelTasksList.getTaskDescList[index] == ''
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    modelTasksList.getTaskDescList[index],
                    style: TextStyle(
                        decoration: modelTasksList.getStatus[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 3,
                        decorationColor: modelSaveConfig.getAccent(),
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.bottomLeft,
                    icon: modelTasksList.getStatus[index] == true
                        ? Icon(
                            Icons.check_circle_rounded,
                            size: 30,
                            color: modelSaveConfig.getAccent(),
                          )
                        : Icon(
                            Icons.check_circle_outline_rounded,
                            size: 30,
                          ),
                    onPressed: () => modelTasksList.changeStatus(index)),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('\t' + modelTasksList.getDateTime[index],
                      style: const TextStyle(fontSize: 13)),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
