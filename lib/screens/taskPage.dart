import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letsdoit/utils/gridCard.dart';
import 'package:letsdoit/utils/taskCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:letsdoit/screens/about.dart';
import 'package:letsdoit/screens/settings.dart';
import 'package:letsdoit/constants/Constants.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key? key}) : super(key: key);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future getData() async {
    await Provider.of<TasksList>(context, listen: false).readContent();
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

  void selected(String choice) async {
    switch (choice) {
      case 'Settings':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settings()));

        break;
      case 'About':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => About()));
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var modelTasksList = Provider.of<TasksList>(context, listen: false);
    var modelSaveConfig = Provider.of<SaveConfig>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          modelSaveConfig.getGradient()[0],
          modelSaveConfig.getGradient()[1]
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
      child: Consumer<TasksList>(
        builder: (context, value, child) => CustomScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                    icon: const Icon(Icons.done_all_rounded),
                    onPressed: () {
                      modelTasksList.allTasksDone();
                    }),
                IconButton(
                    icon: const Icon(Icons.clear_all_rounded),
                    onPressed: () {
                      Provider.of<TasksList>(context, listen: false)
                          .removeall();
                    }),
                Builder(
                  builder: (context) => PopupMenuButton<String>(
                    onSelected: selected,
                    itemBuilder: (context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              floating: true,
              pinned: true,
              snap: false,
              elevation: 50,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(left: 15, bottom: 5),
                collapseMode: CollapseMode.pin,
                title: Text(
                  'Lets Do It',
                  style: GoogleFonts.reemKufi(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
              ),
            ),
            SliverAnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: modelTasksList.getTaskList.length == 0
                  ? SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/done.png',
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.4)
                        ],
                      ),
                    )
                  : modelSaveConfig.getView()
                      ? SliverPadding(
                          padding: EdgeInsets.only(top: 5.0, bottom: 80.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => Dismissible(
                                      dismissThresholds: {
                                        DismissDirection.startToEnd: 0.3,
                                        DismissDirection.endToStart: 0.3
                                      },
                                      background: const Padding(
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
                                            MediaQuery.of(context).size.width -
                                                170,
                                            30,
                                            30,
                                            0),
                                        child: const Text(
                                          "Remove Task",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      key: ValueKey(value.getTaskList[index]),
                                      onDismissed: (direction) {
                                        modelTasksList.removeTaskValue(index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 0.2),
                                            elevation: 3,
                                            child: taskCard(
                                                context,
                                                modelSaveConfig,
                                                modelTasksList,
                                                index,
                                                value,
                                                _descController,
                                                _taskController)),
                                      ),
                                    ),
                                childCount: value.getTaskList.length),
                          ),
                        )
                      : SliverPadding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 80),
                          sliver: SliverStaggeredGrid.countBuilder(
                            crossAxisCount: 2,
                            itemCount: value.getTaskList.length,
                            itemBuilder: (context, index) => Dismissible(
                              key: ValueKey(value.getTaskList[index]),
                              dismissThresholds: {
                                DismissDirection.startToEnd: 0.7,
                                DismissDirection.endToStart: 0.7
                              },
                              background: Container(
                                padding: const EdgeInsets.only(left: 10),
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Remove Task",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              secondaryBackground: Container(
                                padding: const EdgeInsets.only(right: 10),
                                height: double.infinity,
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  "Remove Task",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              onDismissed: (direction) {
                                value.removeTaskValue(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(),
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                  child: gridCard(
                                      context,
                                      modelSaveConfig,
                                      modelTasksList,
                                      index,
                                      value,
                                      _descController,
                                      _taskController),
                                ),
                              ),
                            ),
                            staggeredTileBuilder: (index) =>
                                const StaggeredTile.fit(1),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
