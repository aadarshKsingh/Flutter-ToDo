import 'package:flutter/material.dart';
import 'package:letsdoit/screens/taskPage.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:provider/provider.dart';
import 'package:letsdoit/utils/saveConfig.dart';

Widget editTask(
    BuildContext context,
    TextEditingController _taskController,
    TextEditingController _descController,
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
                _taskController.text = value.getTaskList[index];
                _descController.text = value.getTaskDescList[index];
                model_tasksList.selectedIndex = model_tasksList.getAvailabeTags
                    .indexOf(model_tasksList.getTag[index]);

                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Form(
                                key: _editKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(children: [
                                      Text("Task Title       :      "),
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty)
                                              return "Please enter some text";
                                            else
                                              return null;
                                          },
                                          controller: _taskController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: model_saveConfig
                                                      .getAccent()
                                                      .withOpacity(0.4),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: model_saveConfig
                                                      .getAccent()
                                                      .withOpacity(0.6),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: model_saveConfig
                                                      .getAccent()
                                                      .withOpacity(0.6),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: model_saveConfig
                                                      .getAccent()
                                                      .withOpacity(0.6),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text("Description    :   "),
                                        Expanded(
                                          child: TextFormField(
                                            textCapitalization:
                                                TextCapitalization.words,
                                            controller: _descController,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: model_saveConfig
                                                        .getAccent()
                                                        .withOpacity(0.4),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: model_saveConfig
                                                        .getAccent()
                                                        .withOpacity(0.6),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: model_saveConfig
                                                        .getAccent()
                                                        .withOpacity(0.6),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: model_saveConfig
                                                        .getAccent()
                                                        .withOpacity(0.6),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Task Tag    :     '),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Wrap(
                                            runSpacing: 5,
                                            spacing: 10,
                                            alignment: WrapAlignment.start,
                                            children: List.generate(
                                              model_tasksList
                                                  .getAvailabeTags.length,
                                              (index) => Consumer<tasksList>(
                                                builder:
                                                    (context, value, child) =>
                                                        ChoiceChip(
                                                  backgroundColor:
                                                      model_saveConfig
                                                          .getAccent()
                                                          .withOpacity(0.3),
                                                  selected: model_tasksList
                                                          .selectedIndex ==
                                                      index,
                                                  label: Text(
                                                    model_tasksList
                                                        .getAvailabeTags[index],
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color: model_saveConfig
                                                          .estimateColor(
                                                              model_saveConfig
                                                                  .getAccent())),
                                                  onSelected: (selected) =>
                                                      model_tasksList
                                                          .changeIndex(index),
                                                  selectedColor:
                                                      model_saveConfig
                                                          .getAccent(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color:
                                                  model_saveConfig.getAccent(),
                                              onPressed: () {
                                                if (_editKey.currentState
                                                    .validate()) {
                                                  model_tasksList.updateTask(
                                                      _taskController.text,
                                                      _descController.text,
                                                      index);

                                                  Navigator.pop(context);
                                                }
                                              }),
                                          RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color:
                                                  model_saveConfig.getAccent(),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
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
