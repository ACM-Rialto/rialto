import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'profile.dart';
//import 'products.dart';

class Home extends StatefulWidget
{
  State<StatefulWidget> createState()
  {
    return _HomeState();
  }
}

class _HomeState extends State<Home>
{
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    PlaceholderWidget(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch()
                );
            }
          )
        ],
      ),
      drawer: Drawer(),

      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text('Explore'),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>
{
  final prods = [
      "Camera",
      "Sweatshirt",
      "Calculator",
      "Scantron",
      "Pen",
      "Pencil",
      "conditioner",
      "key chain",
      "mirror",
      "speakers",
      "chair",
      "mop",
      "button",
      "cork",
      "slipper",
      "controller",
      "knife",
      "remote",
      "soap",
      "Thing1",
      "Thing2"
    ];

    final recentProds = [
      "Camera",
      "Thing1",
      "Thing2"
    ];

  @override
  List<Widget> buildActions(BuildContext context) 
  {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
         },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context,null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.lightGreen,
          child: Center(
            child:Text(query),
          ),
          ),
          ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
    ? recentProds
    : prods.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context,index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.search),
        title: Text(suggestionList[index]),
        ),
        itemCount: suggestionList.length,
      );   
  }
}