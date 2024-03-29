import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);
  @override
  _AddTaskState createState() => _AddTaskState();
}

_updateTasks(String title, String subtitle, BuildContext context) {
  Provider.of<TasksList>(context, listen: false).addtaskValue(title, subtitle);
}

class _AddTaskState extends State<AddTask> {
  TextEditingController? taskContr;
  TextEditingController? taskContr2;
  final _taskKey = GlobalKey<FormState>();
  @override
  void initState() {
    taskContr = TextEditingController();
    taskContr2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    taskContr!.dispose();
    taskContr2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var modelTasksList = Provider.of<TasksList>(context, listen: false);
    var modelSaveConfig = Provider.of<SaveConfig>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Material(
        color: modelSaveConfig.getAccent(),
        child: Container(
          padding: const EdgeInsets.only(
            top: 5,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              modelSaveConfig.getGradient()[0],
              modelSaveConfig.getGradient()[1]
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Form(
              key: _taskKey,
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        if (_taskKey.currentState!.validate()) {
                          _updateTasks(
                              taskContr!.text, taskContr2!.text, context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Task Added", gravity: ToastGravity.BOTTOM);
                        }
                      },
                    )
                  ],
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  floating: true,
                  pinned: false,
                  snap: true,
                  elevation: 50,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    stretchModes: [StretchMode.fadeTitle],
                    titlePadding: EdgeInsets.only(left: 15, bottom: 5),
                    collapseMode: CollapseMode.pin,
                    title: Text(
                      'Add a new task',
                      style: GoogleFonts.reemKufi(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.03),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: TextFormField(
                          style: TextStyle(
                              color: modelSaveConfig.estimateColor(
                                  modelSaveConfig.getGradient()[0])),
                          maxLines: 1,
                          autocorrect: true,
                          autofocus: true,
                          controller: taskContr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter some text";
                            } else if (modelTasksList.getTaskList
                                .contains(value)) {
                              return "Please add a different task";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: modelSaveConfig
                                      .estimateColor(
                                          modelSaveConfig.getGradient()[0])
                                      .withOpacity(0.4),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: modelSaveConfig
                                      .estimateColor(
                                          modelSaveConfig.getGradient()[0])
                                      .withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: modelSaveConfig
                                      .estimateColor(
                                          modelSaveConfig.getGradient()[0])
                                      .withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: modelSaveConfig
                                      .estimateColor(
                                          modelSaveConfig.getGradient()[0])
                                      .withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Task Title",
                            hintText: "Enter your task",
                            hintStyle: TextStyle(
                                color: modelSaveConfig.estimateColor(
                                    modelSaveConfig.getGradient()[0])),
                            labelStyle: TextStyle(
                                fontSize: 17,
                                color: modelSaveConfig.estimateColor(
                                    modelSaveConfig.getGradient()[0])),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: TextFormField(
                          style: TextStyle(
                              color: modelSaveConfig.estimateColor(
                                  modelSaveConfig.getGradient()[0])),
                          autocorrect: true,
                          maxLines: 7,
                          controller: taskContr2,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: modelSaveConfig
                                      .estimateColor(
                                          modelSaveConfig.getGradient()[0])
                                      .withOpacity(0.4),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: modelSaveConfig
                                      .estimateColor(
                                          modelSaveConfig.getGradient()[0])
                                      .withOpacity(0.6),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Task Description(Optional)",
                            hintText: "Enter your task Description",
                            hintStyle: TextStyle(
                                color: modelSaveConfig.estimateColor(
                                    modelSaveConfig.getGradient()[0])),
                            labelStyle: TextStyle(
                              fontSize: 17,
                              color: modelSaveConfig.estimateColor(
                                  modelSaveConfig.getGradient()[0]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                        child: Text(
                          "Tags : ",
                          style: TextStyle(
                              fontSize: 17,
                              color: modelSaveConfig.estimateColor(
                                  modelSaveConfig.getGradient()[0])),
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
                              modelTasksList.getAvailabeTags.length,
                              (index) => Consumer<TasksList>(
                                builder: (context, value, child) => ChoiceChip(
                                  backgroundColor: modelSaveConfig
                                      .getAccent()
                                      .withOpacity(0.3),
                                  selected:
                                      modelTasksList.selectedIndex == index,
                                  label: Text(
                                    modelTasksList.getAvailabeTags[index],
                                  ),
                                  labelStyle: TextStyle(
                                      color: modelSaveConfig.estimateColor(
                                          modelSaveConfig.getAccent())),
                                  onSelected: (selected) =>
                                      modelTasksList.changeIndex(index),
                                  selectedColor: modelSaveConfig.getAccent(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
