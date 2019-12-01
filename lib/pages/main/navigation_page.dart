import 'package:flutter/material.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/cart/cart.dart';
import 'package:rialto/pages/main/explore/explore_page.dart';
import 'package:rialto/pages/main/profile.dart';

class NavigationPageViewer extends StatefulWidget {
  final RialtoUser rialtoUser;

  NavigationPageViewer(this.rialtoUser);

  State<StatefulWidget> createState() {
    return _NavigationPageViewerState();
  }
}

class _NavigationPageViewerState extends State<NavigationPageViewer> {
  int _currentIndex = 0;
  List<NavigationPage> _children;
  final _pageController = PageController();

  void initState() {
    super.initState();
    _children = [
      ExplorePage(widget.rialtoUser),
      CartPage(widget.rialtoUser),
      Profile(widget.rialtoUser),
    ];
  }

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
