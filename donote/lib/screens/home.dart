import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:donote/screens/homePage.dart';
import 'package:donote/screens/posts.dart';
import 'package:donote/sevices/authenticate.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [
    HomePage(),
    Posts(),
  ];

  List<IconData> icons = [Icons.dashboard, Icons.list];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[800],
        child: Icon(
          Icons.post_add_sharp,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        children: [screens[_selectedIndex]],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        activeColor: Colors.indigo[800],
        inactiveColor: Colors.grey[500],
        splashColor: Theme.of(context).accentColor,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
