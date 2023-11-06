import 'dart:ui';

import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [const Home(), const Settings()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: BottomNavigationBar(
              currentIndex: currentIndex,
              backgroundColor: Colors.black.withOpacity(.1),
              type: BottomNavigationBarType.fixed,
              onTap: onTap,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade500,
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore_outlined),
                    activeIcon: Icon(Icons.explore_rounded),
                    label: 'Settings'),
                // BottomNavigationBarItem(
                //     icon: Icon(Icons.favorite_border),
                //     activeIcon: Icon(Icons.favorite),
                //     label: 'Liked'),
              ]),
        ),
      ),
    );
  }
}
