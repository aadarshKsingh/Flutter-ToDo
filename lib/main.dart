import 'package:letsdoit/screens//about.dart';
import 'package:letsdoit/screens/addTask.dart';
import 'package:letsdoit/screens/taskPage.dart';
import 'package:letsdoit/screens/settings.dart';
import 'package:letsdoit/utils/tasksList.dart';
import 'package:letsdoit/constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => tasksList()),
    ChangeNotifierProvider(create: (_) => saveConfig())
  ], child: home()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
    getConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(),
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
    var model_tasksList = Provider.of<tasksList>(context, listen: false);
    var model_saveConfig = Provider.of<saveConfig>(context, listen: false);
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: model_saveConfig.getAccent(),
          icon: Icon(Icons.create,
              color:
                  model_saveConfig.estimateColor(model_saveConfig.getAccent())),
          label: Text(
            "Add Task",
            style: TextStyle(
                fontSize: 20,
                color: model_saveConfig
                    .estimateColor(model_saveConfig.getAccent())),
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
        appBar: AppBar(
          elevation: 10,
          toolbarHeight: 60.2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
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
                      model_tasksList.allTasksDone();
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
