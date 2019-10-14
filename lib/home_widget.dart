import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'package:floating_search_bar/floating_search_bar.dart';


class Home extends StatefulWidget
{
  State<StatefulWidget> createState()
  {
    return _HomeState();
  }
}

class _HomeState extends State<Home>
{
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.greenAccent),
    Text('CART'),
    Text('PROFILE')
  ];
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.search),
            onPressed: () {
              print("Search pressed");
            },
          )
        ],
      ),

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
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
              title: new Text('Profile')
          )
        ],
      ),
    );
  }

  Widget buildRow()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/images/desk.jpg'),
        Image.asset('assets/images/desk.jpg'),
        Image.asset('assets/images/desk.jpg')
      ],
    );
  }
  void onTabTapped(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }
}