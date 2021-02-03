import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasksList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letsdoit/saveConfig.dart';

class addTask extends StatefulWidget {
  @override
  _addTaskState createState() => _addTaskState();
}

_updateTasks(String title, String subtitle, BuildContext context) {
  Provider.of<tasksList>(context, listen: false).addtaskValue(title, subtitle);
}

class _addTaskState extends State<addTask> {
  TextEditingController taskContr;
  TextEditingController taskContr2;
  final _taskKey = GlobalKey<FormState>();
  @override
  void initState() {
    taskContr = TextEditingController();
    taskContr2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    taskContr.dispose();
    taskContr2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model_tasksList = Provider.of<tasksList>(context, listen: false);
    var model_saveConfig = Provider.of<saveConfig>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'OnePlusSans',
          primaryColor: model_saveConfig.getAccent(),
        ),
        home: Container(
          padding: EdgeInsets.only(
            top: 5,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              model_saveConfig.getGradient()[0],
              model_saveConfig.getGradient()[1]
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                "Add a new task",
                style: TextStyle(fontSize: 25),
              ),
            ),
            body: Form(
              key: _taskKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: TextFormField(
                        style: TextStyle(
                            color: model_saveConfig.estimateColor(
                                model_saveConfig.getGradient()[0])),
                        maxLines: 1,
                        autocorrect: true,
                        autofocus: true,
                        controller: taskContr,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please enter some text";
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: model_saveConfig
                                    .estimateColor(
                                        model_saveConfig.getGradient()[0])
                                    .withOpacity(0.4),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: model_saveConfig
                                    .estimateColor(
                                        model_saveConfig.getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: model_saveConfig
                                    .estimateColor(
                                        model_saveConfig.getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: model_saveConfig
                                    .estimateColor(
                                        model_saveConfig.getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Task Title",
                          hintText: "Enter your task",
                          hintStyle: TextStyle(
                              color: model_saveConfig.estimateColor(
                                  model_saveConfig.getGradient()[0])),
                          labelStyle: TextStyle(
                              fontFamily: "OnePlusSans",
                              fontSize: 17,
                              color: model_saveConfig.estimateColor(
                                  model_saveConfig.getGradient()[0])),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: TextFormField(
                        style: TextStyle(
                            color: model_saveConfig.estimateColor(
                                model_saveConfig.getGradient()[0])),
                        autocorrect: true,
                        maxLines: 7,
                        controller: taskContr2,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: model_saveConfig
                                    .estimateColor(
                                        model_saveConfig.getGradient()[0])
                                    .withOpacity(0.4),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: model_saveConfig
                                    .estimateColor(
                                        model_saveConfig.getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Task Description(Optional)",
                          hintText: "Enter your task Description",
                          hintStyle: TextStyle(
                              color: model_saveConfig.estimateColor(
                                  model_saveConfig.getGradient()[0])),
                          labelStyle: TextStyle(
                            fontFamily: "OnePlusSans",
                            fontSize: 17,
                            color: model_saveConfig.estimateColor(
                                model_saveConfig.getGradient()[0]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 15, 0, 0),
                      child: Text(
                        "Tags : ",
                        style: TextStyle(
                            fontSize: 17,
                            color: model_saveConfig.estimateColor(
                                model_saveConfig.getGradient()[0])),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Wrap(
                          runSpacing: 5,
                          spacing: 10,
                          alignment: WrapAlignment.start,
                          children: List.generate(
                            model_tasksList.getAvailabeTags.length,
                            (index) => Consumer<tasksList>(
                              builder: (context, value, child) => ChoiceChip(
                                backgroundColor: model_saveConfig
                                    .getAccent()
                                    .withOpacity(0.3),
                                selected:
                                    model_tasksList.selectedIndex == index,
                                label: Text(
                                  model_tasksList.getAvailabeTags[index],
                                ),
                                labelStyle: TextStyle(
                                    color: model_saveConfig.estimateColor(
                                        model_saveConfig.getAccent())),
                                onSelected: (selected) =>
                                    model_tasksList.changeIndex(index),
                                selectedColor: model_saveConfig.getAccent(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      color: model_saveConfig.getAccent(),
                      textColor: model_saveConfig
                          .estimateColor(model_saveConfig.getAccent()),
                      child: Text(
                        "Add",
                        style: TextStyle(fontSize: 25),
                      ),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        if (_taskKey.currentState.validate()) {
                          _updateTasks(
                              taskContr.text, taskContr2.text, context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Task Added", gravity: ToastGravity.BOTTOM);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
