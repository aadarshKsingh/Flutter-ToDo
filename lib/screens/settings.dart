import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsdoit/utils/saveConfig.dart';

List<String> Settings = ['Themes'];
List<Color> background1 = [
  Color(0xFFff9966),
  Color(0xFF00F260),
  Color(0xFF000046),
  Color(0xFF000000),
  Color(0xFF02aab0),
  Color(0xFF4568dc),
  Color(0xFFc2e9fb),
  Color(0xFFfad0c4),
  Color(0xFFE2E2E2),
  Color(0xFFeef2f3),
];
List<Color> background2 = [
  Color(0xFFff5e62),
  Color(0xFF0575E6),
  Color(0xFF1CB5E0),
  Color(0xFF434343),
  Color(0xFF00cdac),
  Color(0xFFb06ab3),
  Color(0xFFa1c4fd),
  Color(0xFFff9a9e),
  Color(0xFFC9D6FF),
  Color(0xFF8e9eab),
];
List<Color> AccentColor = [
  Color(0xFFe53935),
  Color(0xFF3498db),
  Colors.lightBlueAccent,
  Colors.blueGrey,
  Color(0xFF1abc9c),
  Colors.deepPurpleAccent,
  Colors.indigoAccent,
  Colors.deepOrangeAccent,
  Color(0xFF6fa5fc),
  Color(0xFF2c3e50),
];

class settings extends StatelessWidget {
  Widget build(BuildContext context) {
    var model_saveConfig = Provider.of<saveConfig>(context, listen: false);
    return Material(
      color: Provider.of<saveConfig>(context).getAccent(),
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Settings"),
        ),
        body: ListView.builder(
            itemCount: Settings.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                      title: Text("Choose theme"),
                      onTap: () => showModalBottomSheet<dynamic>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          context: context,
                          builder: (_) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: GridView.builder(
                                  itemCount: background1.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 16 / 10),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 100,
                                      child: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      background1[index],
                                                      background2[index]
                                                    ],
                                                    begin: Alignment.bottomLeft,
                                                    end: Alignment.topRight)),
                                          ),
                                          onTap: () {
                                            model_saveConfig.changeBackground(
                                                background1[index],
                                                background2[index]);
                                            model_saveConfig.changeAccent(
                                                AccentColor[index]);
                                            Navigator.pop(context);
                                          }),
                                    );
                                  }),
                            );
                          })),
                  ListTile(
                    title: Text("Change Task View"),
                    onTap: () => showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        context: context,
                        builder: (context) => Wrap(children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                        title: Text("List View"),
                                        trailing:
                                            model_saveConfig.getView() == true
                                                ? Icon(
                                                    Icons.check,
                                                    color: model_saveConfig
                                                        .getAccent(),
                                                  )
                                                : const SizedBox(),
                                        onTap: () =>
                                            model_saveConfig.changeView(true)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text("Grid View"),
                                      trailing: model_saveConfig.getView() ==
                                              false
                                          ? Icon(
                                              Icons.check,
                                              color:
                                                  model_saveConfig.getAccent(),
                                            )
                                          : const SizedBox(),
                                      onTap: () =>
                                          model_saveConfig.changeView(false),
                                    ),
                                  )
                                ],
                              ),
                            ])),
                  ),
                  ListTile(
                    title: Text("Reset settings"),
                    onTap: () => Provider.of<saveConfig>(context, listen: false)
                        .resetConfig(),
                  )
                ],
              );
            }),
      ),
    );
  }
}
