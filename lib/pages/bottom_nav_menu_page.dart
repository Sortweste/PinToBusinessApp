import 'package:demo/pages/tabs/products_page/products.dart';
import 'package:demo/pages/tabs/clients_page/clients.dart';
import 'package:demo/pages/tabs/sales_page/sales.dart';
import 'package:demo/pages/tabs/profile_page/profile.dart';
import 'package:demo/pages/tabs/preorder_page/preorder.dart';
import 'package:demo/provider/bottom_nav_menu_provider.dart';
import 'package:demo/widgets/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final _navigationProvider = Provider.of<TabsNavigationProvider>(context);

    return Scaffold(
      body: PageView(
        controller: _navigationProvider.pageController,
         physics: NeverScrollableScrollPhysics(),
         children: [
           ProductsPage(),
           ClientsPage(),
           SalesPage(),
           PreorderPage(),
           ProfilePage(),
         ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}