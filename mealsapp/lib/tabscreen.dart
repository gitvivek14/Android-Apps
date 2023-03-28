import 'package:flutter/material.dart';
import '/Models/Categories.dart';
import '/categories_screen.dart';
import '/categorymeals_screen.dart';
import '/favourite_screen.dart';
import '/main_drawer.dart';
import 'Models/meals.dart';

class TabsScreen extends StatefulWidget {
  //const TabsScreen({super.key});
  
  final List<Meal> favourite;

  TabsScreen(this.favourite);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
    {'page': categories(), 'title': 'Categories'},
    {'page': Favourite(widget.favourite), 'title': 'Your Favourites'},
  ];

    // TODO: implement initState
    super.initState();
  }
  int selectpageindx = 0;
  void selectpage(int index) {
    setState(() {
      selectpageindx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[selectpageindx]['title'] as String),
      ),
      drawer: drawer(),
      body: _pages[selectpageindx]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: selectpage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: selectpageindx,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              backgroundColor: Theme.of(context).primaryColor,
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
              backgroundColor: Theme.of(context).primaryColor)
        ],
      ),
    );
  }
}
