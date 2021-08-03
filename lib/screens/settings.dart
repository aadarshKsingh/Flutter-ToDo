import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:letsdoit/constants/Constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    var modelSaveConfig = Provider.of<SaveConfig>(context, listen: false);
    return Material(
      color: Provider.of<SaveConfig>(context).getAccent(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
                  'Settings',
                  style: GoogleFonts.reemKufi(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ListTile(
                  title: const Text("Choose theme"),
                  onTap: () => showModalBottomSheet<dynamic>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: GridView.builder(
                              itemCount: Constants.background1.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                Constants.background1[index],
                                                Constants.background2[index]
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight),
                                        ),
                                      ),
                                      onTap: () {
                                        modelSaveConfig.changeBackground(
                                            Constants.background1[index],
                                            Constants.background2[index]);
                                        modelSaveConfig.changeAccent(
                                            Constants.accentColor[index]);
                                        Navigator.pop(context);
                                      }),
                                );
                              }),
                        );
                      })),
              ListTile(
                title: const Text("Change Task View"),
                onTap: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    context: context,
                    builder: (context) => Wrap(children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                    title: const Text("List View"),
                                    trailing: modelSaveConfig.getView() == true
                                        ? Icon(
                                            Icons.check,
                                            color: modelSaveConfig.getAccent(),
                                          )
                                        : const SizedBox(),
                                    onTap: () =>
                                        modelSaveConfig.changeView(true)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: const Text("Grid View"),
                                  trailing: modelSaveConfig.getView() == false
                                      ? Icon(
                                          Icons.check,
                                          color: modelSaveConfig.getAccent(),
                                        )
                                      : const SizedBox(),
                                  onTap: () =>
                                      modelSaveConfig.changeView(false),
                                ),
                              )
                            ],
                          ),
                        ])),
              ),
              ListTile(
                title: const Text("Reset settings"),
                onTap: () => Provider.of<SaveConfig>(context, listen: false)
                    .resetConfig(),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
