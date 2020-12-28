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
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Consumer<tasksList>(builder: (context, value, child) {
            if (value.getTaskList.length == 0)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '  ( ╯° - ° ) ╯',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    Text(
                      "You are free as a bird",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                      background: Container(
                        color: Colors.redAccent,
                        child: Padding(
                          child: Text(
                            "Remove Task",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          padding: EdgeInsets.fromLTRB(30, 20, 260, 0),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.redAccent,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(280, 20, 0, 0),
                          child: Text(
                            "Remove Task",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                      key: ValueKey(value.getTaskList[index]),
                      onDismissed: (direction) {
                        Provider.of<tasksList>(context, listen: false)
                            .removeTaskValue(index);
                      },
                      child: Card(
                          color: Colors.redAccent.shade50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          elevation: 3,
                          child: value.getTaskDescList[index].isEmpty
                              ? ListTile(
                                  leading: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                    child: Text(
                                      (index + 1).toString(),
                                    ),
                                  ),
                                  trailing: Text(
                                    value.getDateTime[index],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  title: Text(value.getTaskList[index]),
                                )
                              : ExpansionTile(
                                  leading: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                      child: Text((index + 1).toString())),
                                  title: Text(value.getTaskList[index]),
                                  trailing: Text(
                                    value.getDateTime[index],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  children: [
                                    Container(
                                      height: 40,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 72),
                                        child: Text(
                                          value.getTaskDescList[index],
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                    );
                  });
          }),
        ),
      ]),
    );
  }
}
