import 'package:flutter/material.dart';
import 'package:tourism/map/map.dart';
import 'package:tourism/HomeDetails/home.dart';
import 'package:tourism/HomeDetails/news.dart';
//import 'package:tourism/web/profile.dart';
import 'package:tourism/HomeDetails/searchplaces.dart';
import 'package:tourism/SettingsDetails/settings.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _children = [
    HomePage(), // Your home page
    SearchPage(),
    MapsScreen(), // Your search page
    NewsPage(),
   // FavoriteScreen(),
   // MapsScreen(),
   
   //ProfileScreen(), // Your profile page
   SettingsScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromARGB(255, 35, 54, 70),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
