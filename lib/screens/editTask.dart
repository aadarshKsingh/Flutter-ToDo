import 'package:flutter/material.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:provider/provider.dart';

final _editKey = GlobalKey<FormState>();

Widget editTask(
    BuildContext context,
    TextEditingController? _taskController,
    TextEditingController? _descController,
    TasksList value,
    int index,
    SaveConfig modelSaveConfig,
    TasksList modelTasksList) {
  _taskController!.text = value.getTaskList[index];
  _descController!.text = value.getTaskDescList[index];
  modelTasksList.selectedIndex =
      modelTasksList.getAvailabeTags.indexOf(modelTasksList.getTag[index]);

  return SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    children: [
      const Align(
        alignment: Alignment.centerLeft,
        child: const Padding(
          padding: EdgeInsets.only(left: 15.0, top: 10),
          child: Text(
            "Edit Task",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        width: MediaQuery.of(context).size.width - 30,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Form(
          key: _editKey,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(3)
            },
            children: [
              TableRow(children: [
                const Text("Task Title"),
                const Text(":"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter some text";
                    } else {
                      return null;
                    }
                  },
                  controller: _taskController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: modelSaveConfig.getAccent().withOpacity(0.4),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: modelSaveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: modelSaveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: modelSaveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ]),
              TableRow(
                children: [
                  const Text("Description"),
                  const Text(":"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _descController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  modelSaveConfig.getAccent().withOpacity(0.4),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  modelSaveConfig.getAccent().withOpacity(0.6),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  modelSaveConfig.getAccent().withOpacity(0.6),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  modelSaveConfig.getAccent().withOpacity(0.6),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text('Task Tag'),
                  const Text(":"),
                  Wrap(
                    spacing: 10,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      modelTasksList.getAvailabeTags.length,
                      (index) => Consumer<TasksList>(
                        builder: (context, value, child) => ChoiceChip(
                          backgroundColor:
                              modelSaveConfig.getAccent().withOpacity(0.3),
                          selected: modelTasksList.selectedIndex == index,
                          label: Text(
                            modelTasksList.getAvailabeTags[index],
                          ),
                          labelStyle: TextStyle(
                              color: modelSaveConfig
                                  .estimateColor(modelSaveConfig.getAccent())),
                          onSelected: (selected) =>
                              modelTasksList.changeIndex(index),
                          selectedColor: modelSaveConfig.getAccent(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: modelSaveConfig.getAccent(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_editKey.currentState!.validate()) {
                  modelTasksList.updateTask(
                      _taskController.text, _descController.text, index);

                  Navigator.pop(context);
                }
              }),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: modelSaveConfig.getAccent(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      )
    ],
  );
}
