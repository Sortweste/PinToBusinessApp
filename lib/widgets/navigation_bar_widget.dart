import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final _navigationProvider = Provider.of<TabsNavigationProvider>(context);

    return BottomNavigationBar(
      currentIndex: _navigationProvider.currentPage,
      selectedItemColor: Colors.brown,
      unselectedItemColor: Colors.grey,
      elevation: 5,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      iconSize: 36,
      onTap: (i) => _navigationProvider.currentPage = i,
      items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Container(child: Text('Home'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.panorama_wide_angle),
            title: Container(child: Text('Home'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Container(child: Text('Home'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.filter_9_plus),
            title: Container(child: Text('Home'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Container(child: Text('Home'),),
          ),   
        ]
      );
  }
}