import 'package:flutter/material.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:provider/provider.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Provider.of<SaveConfig>(context).getAccent(),
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("About"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                radius: 50,
              ),
              Text(
                "realityislie",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              SizedBox(height: 80),
              Text(
                "Made using",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              FlutterLogo(
                size: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
