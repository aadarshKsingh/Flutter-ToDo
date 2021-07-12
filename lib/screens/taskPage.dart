import 'package:flutter/material.dart';
import 'package:letsdoit/screens/editTask.dart';
import 'package:letsdoit/utils/gridCard.dart';
import 'package:letsdoit/utils/taskCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:letsdoit/screens/settings.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class taskPage extends StatefulWidget {
  @override
  _taskPageState createState() => _taskPageState();
}

class _taskPageState extends State<taskPage> {
  Future getData() async {
    await Provider.of<tasksList>(context, listen: false).readContent();
  }

  TextEditingController? _taskController;
  TextEditingController? _descController;

  @override
  void initState() {
    getData();
    _taskController = new TextEditingController();
    _descController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskController!.dispose();
    _descController!.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: value.getTaskList.length == 0
                      //<-------------------Empty Column with no Tasks----------------->
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/done.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4)
                            ],
                          ),
                        )
                      //<--------------------Tasks List Here------------------>

                      : model_saveConfig.getView()
                          ? ListView.builder(
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    padding:
                                        EdgeInsets.fromLTRB(40, 30, 260, 0),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  key: ValueKey(value.getTaskList[index]),
                                  onDismissed: (direction) {
                                    model_tasksList.removeTaskValue(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 0.2),
                                        elevation: 3,
                                        child: taskCard(
                                            context,
                                            model_saveConfig,
                                            model_tasksList,
                                            index,
                                            value,
                                            _descController,
                                            _taskController)),
                                  ),
                                );
                              })
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                itemCount: model_tasksList.getTaskList.length,
                                itemBuilder: (context, index) => Dismissible(
                                  key: ValueKey(value.getTaskList[index]),
                                  dismissThresholds: {
                                    DismissDirection.startToEnd: 0.7,
                                    DismissDirection.endToStart: 0.7
                                  },
                                  background: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Remove Task",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    padding: EdgeInsets.only(right: 10),
                                    height: double.infinity,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Remove Task",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    model_tasksList.removeTaskValue(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(),
                                    child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 2),
                                        child: gridCard(
                                            context,
                                            model_saveConfig,
                                            model_tasksList,
                                            index,
                                            value,
                                            _descController,
                                            _taskController)),
                                  ),
                                ),
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.fit(1),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                              ),
                            ),
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
