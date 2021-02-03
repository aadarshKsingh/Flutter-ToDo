import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsdoit/saveConfig.dart';

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
  Colors.amber,
  Colors.deepPurpleAccent,
  Colors.lightBlueAccent,
  Colors.blueGrey,
  Colors.deepOrangeAccent,
  Color(0xFFe67e22),
  Color(0xFF1abc9c),
  Color(0xFF3498db),
  Colors.deepPurple,
  Colors.greenAccent,
  Colors.indigoAccent,
  Color(0xFF2c3e50),
  Colors.limeAccent,
  Color(0xFFe53935),
  Colors.redAccent,
  Color(0xFF6fa5fc),
  Color(0xFFEF6950),
  Color(0xFF34495e),
  Colors.black12,
  Color(0xFFFFB900),
];

class settings extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'OnePlusSans',
        primaryColor: Provider.of<saveConfig>(context).getAccent(),
      ),
      home: Scaffold(
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      title: Text("Choose background"),
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
                                            Provider.of<saveConfig>(context,
                                                    listen: false)
                                                .changeBackground(
                                                    background1[index],
                                                    background2[index]);
                                            Navigator.pop(context);
                                          }),
                                    );
                                  }),
                            );
                          })),
                  ListTile(
                    title: Text("Choose Accent Color"),
                    onTap: () => showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      context: context,
                      builder: (context) => Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: GridView.builder(
                            itemCount: AccentColor.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return MaterialButton(
                                shape: CircleBorder(),
                                color: AccentColor[index],
                                onPressed: () {
                                  Provider.of<saveConfig>(context,
                                          listen: false)
                                      .changeAccent(AccentColor[index]);
                                  Navigator.pop(context);
                                },
                              );
                            }),
                      ),
                    ),
                    trailing: Icon(
                      Icons.color_lens_rounded,
                      color: Provider.of<saveConfig>(context).getAccent(),
                    ),
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
