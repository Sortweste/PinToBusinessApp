import 'package:flutter/material.dart';

class TabsNavigationProvider with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage(int p){
    this._currentPage = p;
    _pageController.jumpToPage(p);
   // _pageController.animateToPage(p, duration: Duration(milliseconds: 125), curve: Curves.easeInExpo);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}