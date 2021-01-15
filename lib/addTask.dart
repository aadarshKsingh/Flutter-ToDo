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
          primaryColor: Provider.of<saveConfig>(context).getAccent(),
        ),
        home: Container(
          padding: EdgeInsets.only(
            top: 5,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Provider.of<saveConfig>(context).getGradient()[0],
              Provider.of<saveConfig>(context).getGradient()[1]
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
          child: Scaffold(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          maxLines: 2,
                          autocorrect: true,
                          autofocus: true,
                          controller: taskContr,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter some text";
                            else if (Provider.of<tasksList>(context,
                                    listen: false)
                                .getTaskList
                                .contains(value))
                              return "Task already Added";
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Task Title",
                            hintText: "Enter your task",
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(
                                fontFamily: "OnePlusSans",
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          autocorrect: true,
                          maxLines: 10,
                          controller: taskContr2,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Task Description(Optional)",
                            hintText: "Enter your task Description",
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(
                                fontFamily: "OnePlusSans",
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: RaisedButton(
                        padding: EdgeInsets.all(0),
                        color: Provider.of<saveConfig>(context).getAccent(),
                        textColor: Colors.white.withOpacity(0.6),
                        child: Text(
                          "Add",
                          style: TextStyle(fontSize: 15),
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
                                msg: "Task Added",
                                gravity: ToastGravity.BOTTOM);
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
      ),
    );
  }
}
