import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'tasksList.dart';

class taskPage extends StatefulWidget {
  @override
  _taskPageState createState() => _taskPageState();
}

class _taskPageState extends State<taskPage> {
  Future getData() async {
    await Provider.of<tasksList>(context, listen: false).readContent();
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFff9966),
          Color(0xFFff5e62),
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
      child: Scaffold(
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
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        Text(
                          "You are free as a bird",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
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
                                  ? ListTile(
                                      contentPadding:
                                          EdgeInsets.only(top: 20, left: 10),
                                      leading: Checkbox(
                                          checkColor: Colors.redAccent,
                                          value: value.getStatus[index],
                                          onChanged: (value) {
                                            Provider.of<tasksList>(context,
                                                    listen: false)
                                                .changeStatus(value, index);
                                          }),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => SimpleDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                      ],
                                                    ),
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
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
                                                                          value.getTaskDescList[
                                                                              index]),
                                                                    )
                                                            ]),
                                                          ],
                                                        ),
                                                      )
                                                    ]));
                                      },
                                      trailing: Container(
                                        child: Card(
                                          margin: EdgeInsets.only(right: 30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          color:
                                              Color.fromRGBO(219, 219, 219, 30),
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
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        value.getTaskList[index],
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  : ListTile(
                                      contentPadding: EdgeInsets.only(
                                          top: 20,
                                          // bottom: 10,
                                          left: 10),
                                      leading: Checkbox(
                                          value: value.getStatus[index],
                                          onChanged: (value) {
                                            Provider.of<tasksList>(context,
                                                    listen: false)
                                                .changeStatus(value, index);
                                          }),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => SimpleDialog(
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
                                                                horizontal: 15,
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
                                                                          value.getTaskDescList[
                                                                              index]),
                                                                    )
                                                            ]),
                                                          ],
                                                        ),
                                                      )
                                                    ]));
                                      },
                                      trailing: Card(
                                        margin: EdgeInsets.only(right: 30),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        color:
                                            Color.fromRGBO(219, 219, 219, 30),
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
                                            style: TextStyle(fontSize: 15),
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
