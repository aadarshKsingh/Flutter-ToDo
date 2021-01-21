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

  estimateColor(Color gradient) {
    if (ThemeData.estimateBrightnessForColor(gradient) == Brightness.dark)
      return Colors.white;
    else
      return Colors.black;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _editKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                              color: estimateColor(Provider.of<saveConfig>(
                                      context,
                                      listen: false)
                                  .getGradient()[0])),
                        ),
                        Text(
                          "You are free as a bird",
                          style: TextStyle(
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'OnePlusSans',
                              color: estimateColor(Provider.of<saveConfig>(
                                      context,
                                      listen: false)
                                  .getGradient()[0])),
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
                            padding: EdgeInsets.fromLTRB(40, 40, 260, 0),
                          ),
                          secondaryBackground: Padding(
                            padding: EdgeInsets.fromLTRB(300, 40, 0, 0),
                            child: Text(
                              "Remove Task",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          key: ValueKey(value.getTaskList[index]),
                          onDismissed: (direction) {
                            Provider.of<tasksList>(context, listen: false)
                                .removeTaskValue(index);
                          },
                          child: Container(
                            height: 100,
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
                                        tileColor: Provider.of<saveConfig>(
                                                context,
                                                listen: false)
                                            .getAccent()
                                            .withOpacity(0.3),
                                        contentPadding:
                                            EdgeInsets.only(top: 20, left: 10),
                                        leading: IconButton(
                                            icon: Provider.of<tasksList>(
                                                            context,
                                                            listen: false)
                                                        .getStatus[index] ==
                                                    true
                                                ? Icon(
                                                    Icons.check_circle_rounded,
                                                    size: 27,
                                                    color:
                                                        Provider.of<saveConfig>(
                                                                context)
                                                            .getAccent(),
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    size: 27,
                                                  ),
                                            onPressed: () =>
                                                Provider.of<tasksList>(context,
                                                        listen: false)
                                                    .changeStatus(index)),
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
                                                                                                  else if (Provider.of<tasksList>(context, listen: false).getTaskList.contains(value))
                                                                                                    return "Task already Added";
                                                                                                  else
                                                                                                    return null;
                                                                                                },
                                                                                                controller: _taskController,
                                                                                                decoration: InputDecoration(
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.4), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.6), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  errorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.6), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.6), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                ),
                                                                                                // initialValue: value.getTaskList[index],
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
                                                                                                          borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.4), width: 2),
                                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                                        ),
                                                                                                        focusedBorder: OutlineInputBorder(
                                                                                                          borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.6), width: 2),
                                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                                        ),
                                                                                                        errorBorder: OutlineInputBorder(
                                                                                                          borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.6), width: 2),
                                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                                        ),
                                                                                                        focusedErrorBorder: OutlineInputBorder(
                                                                                                          borderSide: BorderSide(color: Provider.of<saveConfig>(context, listen: false).getAccent().withOpacity(0.6), width: 2),
                                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                                        ),
                                                                                                      )))
                                                                                              // initialValue: value.getTaskDescList[index] == null ? 'NA' : value.getTaskDescList[index]))
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
                                                                                                  color: Provider.of<saveConfig>(context, listen: false).getAccent(),
                                                                                                  onPressed: () {
                                                                                                    if (_editKey.currentState.validate()) {
                                                                                                      Provider.of<tasksList>(context, listen: false).updateTask(_taskController.text, _descController.text, index);
                                                                                                      Navigator.pop(context);
                                                                                                    }
                                                                                                  }),
                                                                                              RaisedButton(
                                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                                  child: Text(
                                                                                                    "Cancel",
                                                                                                    style: TextStyle(color: Colors.white),
                                                                                                  ),
                                                                                                  color: Provider.of<saveConfig>(context, listen: false).getAccent(),
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
                                                                  vertical: 10),
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
                                                                    ? Text("NA")
                                                                    : Flexible(
                                                                        child: Text(
                                                                            value.getTaskDescList[index]),
                                                                      )
                                                              ]),
                                                            ],
                                                          ),
                                                        )
                                                      ]));
                                        },
                                        trailing: Container(
                                          child: Card(
                                            elevation: 0,
                                            margin: EdgeInsets.only(right: 30),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      Provider.of<saveConfig>(
                                                              context,
                                                              listen: false)
                                                          .getGradient()[0]
                                                          .withOpacity(0.4),
                                                  width: 6),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: Provider.of<saveConfig>(
                                                    context,
                                                    listen: false)
                                                .getAccent()
                                                .withOpacity(0.45),
                                            child: Container(
                                              height: 60,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                value.getDateTime[index],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF1C1C1C)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          value.getTaskList[index],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ListTile(
                                        tileColor: Provider.of<saveConfig>(
                                                context,
                                                listen: false)
                                            .getAccent()
                                            .withOpacity(0.3),
                                        contentPadding: EdgeInsets.only(
                                            top: 20,
                                            // bottom: 10,
                                            left: 10),
                                        leading: IconButton(
                                            icon: Provider.of<tasksList>(
                                                            context,
                                                            listen: false)
                                                        .getStatus[index] ==
                                                    true
                                                ? Icon(
                                                    Icons.check_circle_rounded,
                                                    size: 27,
                                                    color:
                                                        Provider.of<saveConfig>(
                                                                context)
                                                            .getAccent(),
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    size: 27,
                                                  ),
                                            onPressed: () =>
                                                Provider.of<tasksList>(context,
                                                        listen: false)
                                                    .changeStatus(index)),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (context) => SimpleDialog(
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
                                                                      "Task Details")),
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
                                                                  Row(
                                                                      children: [
                                                                        Text(
                                                                            'Task Done     :     '),
                                                                        Text(value
                                                                            .getStatus[index]
                                                                            .toString()),
                                                                      ]),
                                                                  Row(
                                                                      children: [
                                                                        Text(
                                                                            'Description   :   '),
                                                                        value.getTaskDescList[index].isEmpty
                                                                            ? Text("NA")
                                                                            : Flexible(
                                                                                child: Text(value.getTaskDescList[index]),
                                                                              )
                                                                      ]),
                                                                ],
                                                              ),
                                                            )
                                                          ]));
                                        },
                                        trailing: Card(
                                          elevation: 0,
                                          margin: EdgeInsets.only(right: 30),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Provider.of<saveConfig>(
                                                        context,
                                                        listen: false)
                                                    .getGradient()[0]
                                                    .withOpacity(0.4),
                                                width: 6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          color: Provider.of<saveConfig>(
                                                  context,
                                                  listen: false)
                                              .getAccent()
                                              .withOpacity(0.45),
                                          child: Container(
                                            height: 60,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                              value.getDateTime[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF1C1C1C)),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          value.getTaskList[index],
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 20),
                                        ),
                                      ),
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
