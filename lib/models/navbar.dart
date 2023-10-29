import 'package:dictionary_app/screens/settingsscreen.dart';
import 'package:flutter/material.dart';
import '/screens/homescreen.dart';
import '../screens/gamescreen.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> inputList;
  const HomePage({super.key, required this.inputList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const SettingsScreen()
    ];
    return Scaffold(
      body: screens[bottomNavIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.black,
          indicatorColor: Colors.grey.shade300, // Inverted color
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white, // Inverted color
            ),
          ),
        ),
        child: Container(
          color: Colors.black, // Inverted color for the background
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10), // Adjust the top padding as needed
            child: NavigationBar(
              height: 65,
              selectedIndex: bottomNavIndex,
              onDestinationSelected: (bottomNavIndex) =>
                  setState(() => this.bottomNavIndex = bottomNavIndex),
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white, // Inverted color
                  ),
                  selectedIcon: Icon(
                    Icons.home,
                    color: Colors.white, // Inverted color
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.list_alt_rounded,
                    color: Colors.white, // Inverted color
                  ),
                  selectedIcon: Icon(
                    Icons.list_alt,
                    color: Colors.white, // Inverted color
                  ),
                  label: 'Word List',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white, // Inverted color
                  ),
                  selectedIcon: Icon(
                    Icons.settings,
                    color: Colors.white, // Inverted color
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
