import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasksList.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addTask extends StatefulWidget {
  @override
  _addTaskState createState() => _addTaskState();
}

List<String> pendingTasks = [];

_updateTasks(String title, String subtitle, BuildContext context) {
  // pendingTasks.add(value);
  Provider.of<tasksList>(context, listen: false).addtaskValue(title, subtitle);
}

class _addTaskState extends State<addTask> {
  TextEditingController taskContr;
  TextEditingController taskContr2;
  final _taskKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState

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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'OnePlusSans'),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: Color.fromRGBO(176, 0, 32, 1),
            title: Text(
              "Add a new task",
              style:
                  TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 25),
            ),
          ),
          body: Form(
            key: _taskKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextFormField(
                      maxLines: 2,
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Task Title",
                        hintText: "Enter your task",
                        labelStyle: TextStyle(
                          fontFamily: "OnePlusSans",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      autocorrect: true,
                      maxLines: 10,
                      controller: taskContr2,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Task Description(Optional)",
                        hintText: "Enter your task Description",
                        labelStyle: TextStyle(
                          fontFamily: "OnePlusSans",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      color: Color.fromRGBO(176, 0, 32, 1),
                      textColor: Colors.white.withOpacity(0.6),
                      child: Text("Add"),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
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
