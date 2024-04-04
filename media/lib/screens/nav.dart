import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:media/screens/friends/friends.dart';
import 'package:media/screens/home/home.dart';
import 'package:media/screens/liked/liked.dart';
import 'package:media/screens/settings/settings.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> with SingleTickerProviderStateMixin {
  late PageController pageController;
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Colors.deepOrange),
          Icon(Icons.favorite, color: Colors.deepOrange),
          Icon(Icons.person, color: Colors.deepOrange),
          Icon(Icons.settings, color: Colors.deepOrange),
        ],
        inactiveIcons: const [
          Icon(Icons.home, color: Colors.orangeAccent),
          Icon(Icons.favorite, color: Colors.orangeAccent),
          Icon(Icons.person, color: Colors.orangeAccent),
          Icon(Icons.settings, color: Colors.orangeAccent),
        ],
        color: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.deepOrange,
        elevation: 10,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          tabIndex = v;
        },
        children: const [
          HomeScreen(),
          LikedScreen(),
          FriendsScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
