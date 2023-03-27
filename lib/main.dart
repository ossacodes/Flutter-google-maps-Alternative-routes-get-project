import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_routes_app/map_page.dart';

import 'emergencycall_page.dart';
import 'loadcard_page.dart';
import 'lrtmap_page.dart';
import 'news_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Navigation Bar Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue, // set primary color to blue
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;


  static final List<Widget> _widgetOptions = <Widget>[
    MapPage(),
    NewsPage(),
    LoadCardPage(),
    LRTMapPage(),
    EmergencyCallPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? AppBar(
        toolbarHeight: 0,
        elevation: 0,
      )  : AppBar(
        title: const Text('App Bar'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue, // set background color to blue
        unselectedItemColor: Colors.white, // set unselected item color to white
        selectedItemColor: Colors.white, // set selected item color to white
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false, // hide labels on selected item
        showUnselectedLabels: false, // hide labels on unselected items
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.train),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: '',
          ),
        ],
      ),
    );
  }
}