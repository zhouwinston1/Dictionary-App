import 'package:flutter/material.dart';
import '/screens/homescreen.dart';
import '/screens/listscreen.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> inputList;
  HomePage({super.key, required this.inputList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavIndex = 0;


  @override
  Widget build(BuildContext context) {
    final screens = [
    HomeScreen(),
    ListScreen(wordList: widget.inputList),
  ];
    return Scaffold(
      body: screens[bottomNavIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            )),
        child: NavigationBar(
          height: 65,
          selectedIndex: bottomNavIndex,
          onDestinationSelected: (bottomNavIndex) =>
              setState(() => this.bottomNavIndex = bottomNavIndex),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.list_alt_rounded),
                selectedIcon: Icon(Icons.list_alt),
                label: 'Word List'),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
