import 'package:flutter/material.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/screens/viewTask.dart';

Widget taskCard(
    BuildContext context,
    SaveConfig modelSaveConfig,
    TasksList modelTasksList,
    int index,
    TasksList value,
    TextEditingController? _descController,
    TextEditingController? _taskController) {
  return ListTileTheme(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: ListTile(
      tileColor: modelSaveConfig.getAccent().withOpacity(0.3),
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      leading: IconButton(
          icon: modelTasksList.getStatus[index] == true
              ? Icon(
                  Icons.check_circle_rounded,
                  size: 27,
                  color: modelSaveConfig.getAccent(),
                )
              : const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 27,
                ),
          onPressed: () => modelTasksList.changeStatus(index)),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => viewTask(context, _taskController, _descController,
                value, index, modelSaveConfig, modelTasksList));
      },
      trailing: Card(
          elevation: 0,
          margin: const EdgeInsets.only(right: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: modelSaveConfig.getAccent().withOpacity(0.25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "\t" + value.getDateTime[index],
                  style: const TextStyle(
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
                    decorationColor: modelSaveConfig.getAccent(),
                    decorationStyle: TextDecorationStyle.solid),
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
                    margin: const EdgeInsets.only(bottom: 0, right: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: Text(
                      modelTasksList.getTag[index],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
          ],
        ),
      ),
    ),
  );
}
