import 'package:app_demo_flutter/constants/Colors.dart';
import 'package:app_demo_flutter/screens/EditProfile.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'Search.dart';

class MenuNavigation extends StatefulWidget {
  @override
  _MenuNavigationState createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  @override

  int _currentIndex = 0;

  final _tabs = [
    Center(child: Home()),
    Center(child: Search()),
    Center(child: EditProfile())
  ];


  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.RED_BUTTON_COLOR,
          primaryColor: Colors.white
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Busca"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                label: "Perfil"
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
