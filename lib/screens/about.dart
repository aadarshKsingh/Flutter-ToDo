import 'package:flutter/material.dart';
import 'package:letsdoit/utils/saveConfig.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'About',
                  style: GoogleFonts.reemKufi(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/avatar.jpg',
                  ),
                ),
              ),
              Text(
                "realityislie",
                textAlign: TextAlign.center,
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
            ]))
          ],
        ),
      ),
    );
  }
}
