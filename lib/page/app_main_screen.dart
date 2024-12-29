import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sippify/colors.dart';
import 'package:sippify/models/icon_model.dart';

class CoffeeAppMainScreen extends StatefulWidget {
  const CoffeeAppMainScreen({super.key});

  @override
  State<CoffeeAppMainScreen> createState() => _CoffeeAppMainScreenState();
}

class _CoffeeAppMainScreenState extends State<CoffeeAppMainScreen> {
  int indexMenu = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main body content
      body: menu[indexMenu]['destination'] as Widget,
      backgroundColor: xbackgroundColor,

      // Bottom navigation bar using GoogleNavBar
      bottomNavigationBar: Container(
        color: xbackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GNav(
          selectedIndex: indexMenu,
          onTabChange: (index) {
            setState(() {
              indexMenu = index;
            });
          },
          gap: 8, // Spacing between icon and text
          activeColor: xprimaryColor, // Active tab color
          color: xsecondaryColor, // Inactive tab color
          backgroundColor: xbackgroundColor, // Background color
          iconSize: 24, // Icon size
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Item padding
          tabBorderRadius: 20, // Rounded tab corners
          tabBackgroundColor: xprimaryColor.withOpacity(0.1), // Tab background for active state
          tabs: List.generate(menu.length, (index) {
            Map items = menu[index];
            return GButton(
              icon: items['icon'],
              text: items['label'] ?? '', // Add labels for accessibility
              haptic: true, // Adds haptic feedback on tap
            );
          }),
        ),
      ),
    );
  }
}
