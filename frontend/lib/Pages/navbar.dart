import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Pages/ProfilePage/profile_page.dart';
import 'package:frontend/Pages/UI/home_page.dart';
import 'package:frontend/Pages/UI/services/graph.dart';
// import 'package:frontend/Pages/home_page.dart';
// import 'package:frontend/Pages/splash_page.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});
  @override
  State<navbar> createState() => _navBarState();
}

class _navBarState extends State<navbar> {
  int _index = 0;
  List screen = [HomePage(), GraphPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_index],
      bottomNavigationBar: CurvedNavigationBar(
        height: 53,
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          backgroundColor: Colors.transparent,
          // onTap: (value) {
          //   setState(() {
          //     _index = value;
          //   });
          // },
          color: Colors.lightBlueAccent,
          // backgroundColor: Colors.transparent,
          items: [
            Icon(CupertinoIcons.list_bullet_indent),
            Icon(CupertinoIcons.graph_circle),
            Icon(CupertinoIcons.profile_circled)
          ],
          index: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          }),
      // body: (_index==1)?ProfilePage():(_index==2)?splash():Container()
    );
  }
}
