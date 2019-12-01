import 'package:flutter/material.dart';
import 'package:rialto/pages/main/cart/cart.dart';
import 'package:rialto/pages/main/explore/explore_page.dart';
import 'package:rialto/pages/main/profile.dart';

class NavigationPageViewer extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _NavigationPageViewerState();
  }
}

class _NavigationPageViewerState extends State<NavigationPageViewer> {
  int _currentIndex = 0;
  final List<NavigationPage> _children = [
    ExplorePage(),
    CartPage(),
    Profile(),
  ];
  final _pageController = PageController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _children,
        controller: _pageController,
        onPageChanged: onTabTapped,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: new Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

abstract class NavigationPage implements Widget {}
