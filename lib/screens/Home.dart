import 'package:app_demo_flutter/storage/CurrentUser.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 200
        ),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 80,
              backgroundColor: Colors.green,
              backgroundImage: CurrentUser.user.urlImage != null?
              NetworkImage(CurrentUser.user.urlImage):
              ExactAssetImage("assets/images/profile-icon.png"),
            ),
            Container(
              child: Text(
                CurrentUser.user.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            Container(
              child: Text(
                CurrentUser.user.email,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),Container(
              child: Text(
                CurrentUser.user.uid,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
