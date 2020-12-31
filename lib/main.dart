import 'package:letsdoit/about.dart';
import 'package:letsdoit/addTask.dart';
import 'package:letsdoit/taskPage.dart';
import 'package:letsdoit/settings.dart';
import 'package:letsdoit/tasksList.dart';
import 'Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => tasksList())],
    child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'OnePlusSans', accentColor: Color(0xFFe53935)),
        home: letsdoit()),
  ));
}

class letsdoit extends StatefulWidget {
  @override
  _letsdoitState createState() => _letsdoitState();
}

class _letsdoitState extends State<letsdoit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFff9966),
          Color(0xFFff5e62),
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.redAccent,
            icon: Icon(Icons.create),
            label: Text("Add Task"),
            elevation: 20,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => addTask(),
                ),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          backgroundColor: Color(0xFFff5e62),
          appBar: AppBar(
            elevation: 10,
            toolbarHeight: 60.2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Color(0xFFe53935),
            title: Text(
              "Lets Do It!",
              style:
                  TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 25),
            ),
            actions: [
              Consumer<tasksList>(
                builder: (context, value, child) {
                  return IconButton(
                      icon: Icon(Icons.done_all_rounded),
                      onPressed: () {
                        Provider.of<tasksList>(context, listen: false)
                            .allTasksDone();
                      });
                },
              ),
              Consumer<tasksList>(
                builder: (context, value, child) {
                  return IconButton(
                      icon: Icon(Icons.clear_all_rounded),
                      onPressed: () {
                        Provider.of<tasksList>(context, listen: false)
                            .removeall();
                      });
                },
              ),
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
          ),
          body: taskPage()),
    );
  }

  void selected(String choice) async {
    switch (choice) {
      case 'Settings':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => settings()));

        break;
      case 'About':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => about()));
        break;
      default:
        return null;
    }
  }
}
