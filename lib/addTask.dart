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
                            color:
                                Provider.of<saveConfig>(context, listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])),
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
                                color: Provider.of<saveConfig>(context,
                                        listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])
                                    .withOpacity(0.4),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Provider.of<saveConfig>(context,
                                        listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Provider.of<saveConfig>(context,
                                        listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Provider.of<saveConfig>(context,
                                        listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Task Title",
                          hintText: "Enter your task",
                          hintStyle: TextStyle(
                              color: Provider.of<saveConfig>(context,
                                      listen: false)
                                  .estimateColor(Provider.of<saveConfig>(
                                          context,
                                          listen: false)
                                      .getGradient()[0])),
                          labelStyle: TextStyle(
                              fontFamily: "OnePlusSans",
                              fontSize: 17,
                              color: Provider.of<saveConfig>(context,
                                      listen: false)
                                  .estimateColor(Provider.of<saveConfig>(
                                          context,
                                          listen: false)
                                      .getGradient()[0])),
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
                        style: TextStyle(color: Colors.white),
                        autocorrect: true,
                        maxLines: 7,
                        controller: taskContr2,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Provider.of<saveConfig>(context,
                                        listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])
                                    .withOpacity(0.4),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Provider.of<saveConfig>(context,
                                        listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])
                                    .withOpacity(0.6),
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Task Description(Optional)",
                          hintText: "Enter your task Description",
                          hintStyle: TextStyle(
                              color: Provider.of<saveConfig>(context,
                                      listen: false)
                                  .estimateColor(Provider.of<saveConfig>(
                                          context,
                                          listen: false)
                                      .getGradient()[0])),
                          labelStyle: TextStyle(
                            fontFamily: "OnePlusSans",
                            fontSize: 17,
                            color:
                                Provider.of<saveConfig>(context, listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0]),
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
                            color:
                                Provider.of<saveConfig>(context, listen: false)
                                    .estimateColor(Provider.of<saveConfig>(
                                            context,
                                            listen: false)
                                        .getGradient()[0])),
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
                            Provider.of<tasksList>(context, listen: false)
                                .getAvailabeTags
                                .length,
                            (index) => Consumer<tasksList>(
                              builder: (context, value, child) => ChoiceChip(
                                backgroundColor: Provider.of<saveConfig>(
                                        context,
                                        listen: false)
                                    .getAccent()
                                    .withOpacity(0.3),
                                selected: Provider.of<tasksList>(context)
                                        .selectedIndex ==
                                    index,
                                label: Text(
                                  Provider.of<tasksList>(
                                    context,
                                    listen: false,
                                  ).getAvailabeTags[index],
                                ),
                                labelStyle: TextStyle(
                                    color: Provider.of<saveConfig>(context,
                                            listen: false)
                                        .estimateColor(Provider.of<saveConfig>(
                                                context,
                                                listen: false)
                                            .getAccent())),
                                onSelected: (selected) =>
                                    Provider.of<tasksList>(context,
                                            listen: false)
                                        .changeIndex(index),
                                selectedColor: Provider.of<saveConfig>(context,
                                        listen: false)
                                    .getAccent(),
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
                      color: Provider.of<saveConfig>(context).getAccent(),
                      textColor: Provider.of<saveConfig>(context, listen: false)
                          .estimateColor(
                              Provider.of<saveConfig>(context, listen: false)
                                  .getAccent()),
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
