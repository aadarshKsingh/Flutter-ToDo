import 'package:flutter/material.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:provider/provider.dart';

final _editKey = GlobalKey<FormState>();

Widget editTask(
    BuildContext context,
    TextEditingController? _taskController,
    TextEditingController? _descController,
    tasksList value,
    int index,
    saveConfig model_saveConfig,
    tasksList model_tasksList) {
  _taskController!.text = value.getTaskList[index];
  _descController!.text = value.getTaskDescList[index];
  model_tasksList.selectedIndex =
      model_tasksList.getAvailabeTags.indexOf(model_tasksList.getTag[index]);

  return SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10),
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
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(3)
            },
            children: [
              TableRow(children: [
                Text("Task Title"),
                Text(":"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter some text";
                    else
                      return null;
                  },
                  controller: _taskController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: model_saveConfig.getAccent().withOpacity(0.4),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: model_saveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: model_saveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: model_saveConfig.getAccent().withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ]),
              TableRow(
                children: [
                  Text("Description"),
                  Text(":"),
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
                                  model_saveConfig.getAccent().withOpacity(0.4),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  model_saveConfig.getAccent().withOpacity(0.6),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  model_saveConfig.getAccent().withOpacity(0.6),
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  model_saveConfig.getAccent().withOpacity(0.6),
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
                  Text('Task Tag'),
                  Text(":"),
                  Wrap(
                    spacing: 10,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      model_tasksList.getAvailabeTags.length,
                      (index) => Consumer<tasksList>(
                        builder: (context, value, child) => ChoiceChip(
                          backgroundColor:
                              model_saveConfig.getAccent().withOpacity(0.3),
                          selected: model_tasksList.selectedIndex == index,
                          label: Text(
                            model_tasksList.getAvailabeTags[index],
                          ),
                          labelStyle: TextStyle(
                              color: model_saveConfig
                                  .estimateColor(model_saveConfig.getAccent())),
                          onSelected: (selected) =>
                              model_tasksList.changeIndex(index),
                          selectedColor: model_saveConfig.getAccent(),
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
                primary: model_saveConfig.getAccent(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_editKey.currentState!.validate()) {
                  model_tasksList.updateTask(
                      _taskController.text, _descController.text, index);

                  Navigator.pop(context);
                }
              }),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: model_saveConfig.getAccent(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
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
