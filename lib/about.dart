import 'package:flutter/material.dart';

class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OnePlusSans'),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("About"),
          backgroundColor: Color.fromRGBO(176, 0, 32, 1),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
