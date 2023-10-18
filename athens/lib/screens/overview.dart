// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:athens/screens/ranking/ranking_page.dart';
import 'package:athens/screens/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import '../constants/theme_model.dart';
import 'home/home.dart';

class Overview extends StatefulWidget {
  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ThemeModel theme = ThemeModel.instance;
  int _selectedTab = 0;
  final List<Widget> _pageOptions = [Home(), RankingPage(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: Platform.isIOS ? false : true,
      appBar: AppBar(
        actions: [], //_buildActions(),
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: OverViewTitle(_selectedTab),
      ),
      body: _pageOptions[_selectedTab],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedTab = index);
  }

  List<Widget> _buildActions() {
    if (_selectedTab == 0) return [HomeActions()];

    return [];
  }

  Widget _buildBottomNavBar() {
    return Card(
      margin: Platform.isAndroid ? EdgeInsets.all(10) : EdgeInsets.zero,
      shape: Platform.isAndroid
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(17)))
          : RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      elevation: 10,
      child: Container(
        height: Platform.isAndroid ? 60 : null,
        decoration: Platform.isAndroid
            ? BoxDecoration(
                //color: Colors.red,
                gradient: theme.gradient,
                borderRadius: BorderRadius.all(Radius.circular(17)))
            : BoxDecoration(gradient: theme.gradient),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: theme.maincolor,
          currentIndex: _selectedTab,
          iconSize: 26,
          selectedLabelStyle: TextStyle(color: Colors.white),
          onTap: (index) => _onItemTapped(index),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            _buildNavItem(Icons.fastfood_outlined, Icons.fastfood),
            _buildNavItem(Icons.emoji_events_outlined, Icons.emoji_events),
            _buildNavItem(Icons.person_outline, Icons.person),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, IconData activeIcon,
      [double size = 26]) {
    return BottomNavigationBarItem(
      activeIcon: Icon(activeIcon, color: Colors.white, size: size),
      icon: Icon(icon, color: Colors.white, size: size),
      label: '',
    );
  }
}

class OverViewTitle extends StatelessWidget {
  const OverViewTitle(this.tab);
  final String home = 'Waste Warriors';
  final String leaderBoard = 'Leaderboard';
  final String community = 'Profile';
  final int tab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Text(
        _buildTitle(),
        style: TextStyle(
            //Titolo al centro: fontSize: 18, fontWeight.500
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  String _buildTitle() {
    String title = '?';
    switch (tab) {
      case 0:
        title = home;
        break;
      case 2:
        title = community;
        break;
      case 1:
        title = leaderBoard; //classe;
        break;
      default:
        title = home;
    }
    return title;
  }
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  late double _x;
  late double _y;
  @override
  Offset getOffset(
      {required Offset begin, required Offset end, required double progress}) {
    _x = begin.dx + (end.dx - begin.dx) * progress;
    _y = begin.dy + (end.dy - begin.dy) * progress;
    return Offset(_x, _y);
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}
