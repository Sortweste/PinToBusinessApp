import 'package:demo/pages/tabs/tab1_page.dart';
import 'package:demo/pages/tabs/tab2_page.dart';
import 'package:demo/pages/tabs/tab3_page.dart';
import 'package:demo/pages/tabs/tab4_page.dart';
import 'package:demo/pages/tabs/tab5_page.dart';
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
           Tab1Page(),
           Tab2Page(),
           Tab3Page(),
           Tab4Page(),
           Tab5Page(),
         ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}