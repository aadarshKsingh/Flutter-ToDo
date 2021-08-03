import 'package:letsdoit/screens/addTask.dart';
import 'package:letsdoit/screens/taskPage.dart';
import 'package:letsdoit/utils/tasksList.dart';
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
        body: TaskPage());
  }
}
