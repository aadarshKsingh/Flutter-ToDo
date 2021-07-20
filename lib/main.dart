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
    ChangeNotifierProvider(create: (_) => TasksList()),
    ChangeNotifierProvider(create: (_) => SaveConfig())
  ], child: Home()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getConfig() async {
    await Provider.of<SaveConfig>(context, listen: false).readConfig();
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
          primaryColor: Provider.of<SaveConfig>(context).getAccent()),
      home: Scaffold(body: LetsDoIt()),
    );
  }
}

class LetsDoIt extends StatefulWidget {
  LetsDoIt({Key? key}) : super(key: key);

  @override
  _LetsDoItState createState() => _LetsDoItState();
}

class _LetsDoItState extends State<LetsDoIt> {
  @override
  Widget build(BuildContext context) {
    var modelTasksList = Provider.of<TasksList>(context, listen: false);
    var modelSaveConfig = Provider.of<SaveConfig>(context, listen: false);
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: modelSaveConfig.getAccent(),
          icon: Icon(Icons.create,
              color:
                  modelSaveConfig.estimateColor(modelSaveConfig.getAccent())),
          label: Text(
            "Add Task",
            style: TextStyle(
                fontSize: 20,
                color:
                    modelSaveConfig.estimateColor(modelSaveConfig.getAccent())),
          ),
          elevation: 20,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AddTask(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          elevation: 10,
          toolbarHeight: 60.2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          title: const Text(
            "Lets Do It!",
            style: TextStyle(fontSize: 25),
          ),
          actions: [
            Consumer<TasksList>(
              builder: (context, value, child) {
                return IconButton(
                    icon: const Icon(Icons.done_all_rounded),
                    onPressed: () {
                      modelTasksList.allTasksDone();
                    });
              },
            ),
            Consumer<TasksList>(
              builder: (context, value, child) {
                return IconButton(
                    icon: const Icon(Icons.clear_all_rounded),
                    onPressed: () {
                      Provider.of<TasksList>(context, listen: false)
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
        body: TaskPage());
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
}
