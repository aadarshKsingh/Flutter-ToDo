import 'package:letsdoit/about.dart';
import 'package:letsdoit/addTask.dart';
import 'package:letsdoit/taskPage.dart';
import 'package:letsdoit/settings.dart';
import 'package:letsdoit/tasksList.dart';
import 'Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsdoit/saveConfig.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => tasksList()),
    ChangeNotifierProvider(create: (_) => saveConfig())
  ], child: home()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

estimateColor(Color accent) {
  if (ThemeData.estimateBrightnessForColor(accent) == Brightness.dark)
    return Colors.white;
  else
    return Colors.black;
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Future getConfig() async {
    await Provider.of<saveConfig>(context, listen: false).readConfig();
  }

  @override
  void initState() {
    // TODO: implement initState
    getConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'OnePlusSans',
          primaryColor: Provider.of<saveConfig>(context).getAccent()),
      home: Scaffold(body: letsdoit()),
    );
  }
}

class letsdoit extends StatefulWidget {
  @override
  _letsdoitState createState() => _letsdoitState();
}

class _letsdoitState extends State<letsdoit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Provider.of<saveConfig>(context).getAccent(),
          icon: Icon(Icons.create,
              color: estimateColor(
                  Provider.of<saveConfig>(context, listen: false).getAccent())),
          label: Text(
            "Add Task",
            style: TextStyle(
                fontSize: 20,
                color: estimateColor(
                    Provider.of<saveConfig>(context, listen: false)
                        .getAccent())),
          ),
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
        // backgroundColor: Color(0xFFff5e62),
        appBar: AppBar(
          elevation: 10,
          toolbarHeight: 60.2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Lets Do It!",
            style: TextStyle(fontSize: 25),
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
        body: taskPage());
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
