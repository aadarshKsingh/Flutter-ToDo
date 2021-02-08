import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'tasksList.dart';
import 'saveConfig.dart';

class taskPage extends StatefulWidget {
  @override
  _taskPageState createState() => _taskPageState();
}

class _taskPageState extends State<taskPage> {
  Future getData() async {
    await Provider.of<tasksList>(context, listen: false).readContent();
  }

  TextEditingController _taskController;
  TextEditingController _descController;

  @override
  void initState() {
    getData();
    _taskController = new TextEditingController();
    _descController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _editKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var model_tasksList = Provider.of<tasksList>(context, listen: false);
    var model_saveConfig = Provider.of<saveConfig>(context, listen: false);
    return Container(
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
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(children: [
            Expanded(
              child: Consumer<tasksList>(builder: (context, value, child) {
                if (value.getTaskList.length == 0)
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '  ( ╯° - ° ) ╯',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: model_saveConfig.estimateColor(
                                  model_saveConfig.getGradient()[0])),
                        ),
                        Text(
                          "You are free as a bird",
                          style: TextStyle(
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'OnePlusSans',
                              color: model_saveConfig.estimateColor(
                                  model_saveConfig.getGradient()[0])),
                        )
                      ],
                    ),
                  );
                else
                  return ListView.builder(
                      itemCount: value.getTaskList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          dismissThresholds: {
                            DismissDirection.startToEnd: 0.7,
                            DismissDirection.endToStart: 0.7
                          },
                          background: Padding(
                            child: Text(
                              "Remove Task",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            padding: EdgeInsets.fromLTRB(40, 30, 260, 0),
                          ),
                          secondaryBackground: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width - 140,
                                30,
                                30,
                                0),
                            child: Text(
                              "Remove Task",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          key: ValueKey(value.getTaskList[index]),
                          onDismissed: (direction) {
                            model_tasksList.removeTaskValue(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0.2),
                              elevation: 3,
                              child: value.getStatus[index] == false
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ListTile(
                                          tileColor: model_saveConfig
                                              .getAccent()
                                              .withOpacity(0.3),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          leading: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: IconButton(
                                                icon: model_tasksList
                                                            .getStatus[index] ==
                                                        true
                                                    ? Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        size: 27,
                                                        color: model_saveConfig
                                                            .getAccent(),
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_circle_outline_rounded,
                                                        size: 27,
                                                      ),
                                                onPressed: () => model_tasksList
                                                    .changeStatus(index)),
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context:
                                                    _scaffoldKey.currentContext,
                                                builder: (_) => SimpleDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .description_rounded,
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                  "Task Details"),
                                                            ),
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons.edit),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  _taskController
                                                                          .text =
                                                                      value.getTaskList[
                                                                          index];
                                                                  _descController
                                                                          .text =
                                                                      value.getTaskDescList[
                                                                          index];
                                                                  model_tasksList
                                                                          .selectedIndex =
                                                                      model_tasksList
                                                                          .getAvailabeTags
                                                                          .indexOf(
                                                                              model_tasksList.getTag[index]);

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              SimpleDialog(
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width - 30,
                                                                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                    child: Form(
                                                                                      key: _editKey,
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                                                                    borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.4), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  errorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
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
                                                                                                  textCapitalization: TextCapitalization.words,
                                                                                                  controller: _descController,
                                                                                                  maxLines: 5,
                                                                                                  decoration: InputDecoration(
                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.4), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                    errorBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          SizedBox(height: 10),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                                    model_tasksList.getAvailabeTags.length,
                                                                                                    (index) => Consumer<tasksList>(
                                                                                                      builder: (context, value, child) => ChoiceChip(
                                                                                                        backgroundColor: model_saveConfig.getAccent().withOpacity(0.3),
                                                                                                        selected: model_tasksList.selectedIndex == index,
                                                                                                        label: Text(
                                                                                                          model_tasksList.getAvailabeTags[index],
                                                                                                        ),
                                                                                                        labelStyle: TextStyle(color: model_saveConfig.estimateColor(model_saveConfig.getAccent())),
                                                                                                        onSelected: (selected) => model_tasksList.changeIndex(index),
                                                                                                        selectedColor: model_saveConfig.getAccent(),
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
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                              children: [
                                                                                                RaisedButton(
                                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                                    child: Text(
                                                                                                      "Update",
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                    ),
                                                                                                    color: model_saveConfig.getAccent(),
                                                                                                    onPressed: () {
                                                                                                      if (_editKey.currentState.validate()) {
                                                                                                        model_tasksList.updateTask(_taskController.text, _descController.text, index);

                                                                                                        Navigator.pop(context);
                                                                                                      }
                                                                                                    }),
                                                                                                RaisedButton(
                                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                                    child: Text(
                                                                                                      "Cancel",
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                    ),
                                                                                                    color: model_saveConfig.getAccent(),
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
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "Task Title       :     "),
                                                                    Text(value
                                                                            .getTaskList[
                                                                        index])
                                                                  ],
                                                                ),
                                                                Row(children: [
                                                                  Text(
                                                                      'Task Done     :     '),
                                                                  Text(value
                                                                      .getStatus[
                                                                          index]
                                                                      .toString()),
                                                                ]),
                                                                Row(children: [
                                                                  Text(
                                                                      'Description   :   '),
                                                                  value
                                                                          .getTaskDescList[
                                                                              index]
                                                                          .isEmpty
                                                                      ? Text(
                                                                          "NA")
                                                                      : Flexible(
                                                                          child:
                                                                              Text(value.getTaskDescList[index]),
                                                                        )
                                                                ]),
                                                              ],
                                                            ),
                                                          )
                                                        ]));
                                          },
                                          trailing: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: Card(
                                              elevation: 0,
                                              margin: EdgeInsets.only(
                                                  right: 30, top: 2),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: model_saveConfig
                                                        .getGradient()[0]
                                                        .withOpacity(0.4),
                                                    width: 3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              color: model_saveConfig
                                                  .getAccent()
                                                  .withOpacity(0.25),
                                              child: Container(
                                                height: 60,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 3),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  value.getDateTime[index],
                                                  style: TextStyle(
                                                      fontSize: 13.5,
                                                      color: Color(0xFF1C1C1C)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0, top: 10, left: 2),
                                            child: Text(
                                              value.getTaskList[index],
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, bottom: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                model_tasksList.getTag[index] !=
                                                        'None'
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: model_saveConfig
                                                                    .getAccent()
                                                                    .withOpacity(
                                                                        0.6),
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        margin: EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 5),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                        child: Text(
                                                          model_tasksList
                                                              .getTag[index],
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    : Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 5),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                      )
                                              ],
                                            ),
                                          )),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ListTile(
                                          tileColor: model_saveConfig
                                              .getAccent()
                                              .withOpacity(0.3),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          leading: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: IconButton(
                                                icon: model_tasksList
                                                            .getStatus[index] ==
                                                        true
                                                    ? Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        size: 27,
                                                        color: model_saveConfig
                                                            .getAccent(),
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_circle_outline_rounded,
                                                        size: 27,
                                                      ),
                                                onPressed: () => model_tasksList
                                                    .changeStatus(index)),
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context:
                                                    _scaffoldKey.currentContext,
                                                builder: (_) => SimpleDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .description_rounded,
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                  "Task Details"),
                                                            ),
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons.edit),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  _taskController
                                                                          .text =
                                                                      value.getTaskList[
                                                                          index];
                                                                  _descController
                                                                          .text =
                                                                      value.getTaskDescList[
                                                                          index];
                                                                  model_tasksList
                                                                          .selectedIndex =
                                                                      model_tasksList
                                                                          .getAvailabeTags
                                                                          .indexOf(
                                                                              model_tasksList.getTag[index]);

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              SimpleDialog(
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                children: [
                                                                                  Container(
                                                                                      width: MediaQuery.of(context).size.width - 30,
                                                                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                      child: Form(
                                                                                        key: _editKey,
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.4), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                    errorBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            ]),
                                                                                            SizedBox(
                                                                                              height: 20,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                Text("Description    :   "),
                                                                                                Expanded(
                                                                                                  child: TextFormField(
                                                                                                    textCapitalization: TextCapitalization.words,
                                                                                                    controller: _descController,
                                                                                                    maxLines: 5,
                                                                                                    decoration: InputDecoration(
                                                                                                      enabledBorder: OutlineInputBorder(
                                                                                                        borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.4), width: 2),
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                      focusedBorder: OutlineInputBorder(
                                                                                                        borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                      errorBorder: OutlineInputBorder(
                                                                                                        borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                                        borderSide: BorderSide(color: model_saveConfig.getAccent().withOpacity(0.6), width: 2),
                                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(height: 20),
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Text('Task Tag    : '),
                                                                                                Flexible(
                                                                                                  fit: FlexFit.tight,
                                                                                                  flex: 2,
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.only(left: 10),
                                                                                                    child: Wrap(
                                                                                                      runSpacing: 4,
                                                                                                      spacing: 10,
                                                                                                      alignment: WrapAlignment.start,
                                                                                                      children: List.generate(
                                                                                                        model_tasksList.getAvailabeTags.length,
                                                                                                        (index) => Consumer<tasksList>(
                                                                                                          builder: (context, value, child) => ChoiceChip(
                                                                                                            backgroundColor: model_saveConfig.getAccent().withOpacity(0.3),
                                                                                                            selected: model_tasksList.selectedIndex == index,
                                                                                                            label: Text(
                                                                                                              model_tasksList.getAvailabeTags[index],
                                                                                                            ),
                                                                                                            labelStyle: TextStyle(color: model_saveConfig.estimateColor(model_saveConfig.getAccent())),
                                                                                                            onSelected: (selected) => model_tasksList.changeIndex(index),
                                                                                                            selectedColor: model_saveConfig.getAccent(),
                                                                                                          ),
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
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                              children: [
                                                                                                RaisedButton(
                                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                                    child: Text(
                                                                                                      "Update",
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                    ),
                                                                                                    color: model_saveConfig.getAccent(),
                                                                                                    onPressed: () {
                                                                                                      if (_editKey.currentState.validate()) {
                                                                                                        model_tasksList.updateTask(_taskController.text, _descController.text, index);
                                                                                                        Navigator.pop(context);
                                                                                                      }
                                                                                                    }),
                                                                                                RaisedButton(
                                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                                    child: Text(
                                                                                                      "Cancel",
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                    ),
                                                                                                    color: model_saveConfig.getAccent(),
                                                                                                    onPressed: () {
                                                                                                      Navigator.pop(context);
                                                                                                    })
                                                                                              ],
                                                                                            ))
                                                                                          ],
                                                                                        ),
                                                                                      )),
                                                                                ],
                                                                              ));
                                                                })
                                                          ],
                                                        ),
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "Task Title       :     "),
                                                                    Text(value
                                                                            .getTaskList[
                                                                        index])
                                                                  ],
                                                                ),
                                                                Row(children: [
                                                                  Text(
                                                                      'Task Done     :     '),
                                                                  Text(value
                                                                      .getStatus[
                                                                          index]
                                                                      .toString()),
                                                                ]),
                                                                Row(children: [
                                                                  Text(
                                                                      'Description   :   '),
                                                                  value
                                                                          .getTaskDescList[
                                                                              index]
                                                                          .isEmpty
                                                                      ? Text(
                                                                          "NA")
                                                                      : Flexible(
                                                                          child:
                                                                              Text(value.getTaskDescList[index]),
                                                                        )
                                                                ]),
                                                              ],
                                                            ),
                                                          )
                                                        ]));
                                          },
                                          trailing: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: Card(
                                              elevation: 0,
                                              margin: EdgeInsets.only(
                                                  right: 30, top: 2),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: model_saveConfig
                                                        .getGradient()[0]
                                                        .withOpacity(0.4),
                                                    width: 3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              color: model_saveConfig
                                                  .getAccent()
                                                  .withOpacity(0.25),
                                              child: Container(
                                                height: 60,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 3),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  value.getDateTime[index],
                                                  style: TextStyle(
                                                      fontSize: 13.5,
                                                      color: Color(0xFF1C1C1C)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0, top: 10, left: 2),
                                            child: Text(
                                              value.getTaskList[index],
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationThickness: 3,
                                                  decorationColor:
                                                      model_saveConfig
                                                          .getAccent(),
                                                  decorationStyle:
                                                      TextDecorationStyle
                                                          .solid),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, bottom: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                model_tasksList.getTag[index] !=
                                                        'None'
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: model_saveConfig
                                                                    .getAccent()
                                                                    .withOpacity(
                                                                        0.6),
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        margin: EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 5),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                        child: Text(
                                                          model_tasksList
                                                              .getTag[index],
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    : Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 5),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2),
                                                      )
                                              ],
                                            ),
                                          )),
                                    ),
                            ),
                          ),
                        );
                      });
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
