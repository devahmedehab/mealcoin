import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppCustomColors.primaryColor,
        title: Row(
          children: [
            Text(
              'Chefs &',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppCustomColors.blackColor),
            ),
            Text(
              ' Meals',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppCustomColors.whiteColor),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.red,
                ),
                child: UserAccountsDrawerHeader(
                  accountName: Text("UserNameFirst userNameLast"),
                  accountEmail: Text("user@email.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppCustomColors.whiteColor,
                    child: Text(
                      "DP",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("About Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
