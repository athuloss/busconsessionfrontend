import 'package:bus/card.dart';
import 'package:bus/consession_aaply.dart';
import 'package:bus/frontpage.dart';
import 'package:bus/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/widgets.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Frontpage(),
    Consession(),
    Profile(),
    Cardconsession()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor:Color(0xFF75E5A2)  ,
        body: _pages[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          color: Color(0xFF38A3A5),
          buttonBackgroundColor: Color(0xFF38A3A5),
          animationDuration: Duration(milliseconds: 300),
          height: 60,
          items: [
            Icon(Icons.home,
                size: 30,
                color: _selectedIndex == 0
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 255, 255, 255)),
            Icon(Icons.chat,
                size: 30,
                color: _selectedIndex == 1
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 255, 255, 255)),
            Icon(Icons.person,
                size: 30,
                color: _selectedIndex == 3
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 255, 255, 255)),
            Icon(Icons.badge,
                size: 30,
                color: _selectedIndex == 3
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 255, 255, 255)),
            // Icon(Icons.chat, size: 30, color: _selectedIndex == 2 ? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 0, 0)),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }
}
