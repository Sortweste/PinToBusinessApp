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
      iconSize: 32,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (i) => _navigationProvider.currentPage = i,
      items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            title: Container(child: Text('Productos'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Container(child: Text('Clientes'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Container(child: Text('Ventas'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Container(child: Text('Reservas'),),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Container(child: Text('Perfil'),),
          ),   
        ]
      );
  }
}