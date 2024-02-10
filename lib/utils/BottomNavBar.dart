import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) handleNavigation;
  const BottomNavBar({super.key, required this.handleNavigation, required this.currentIndex});

  final int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    //bottom navigation bar
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: "Activités",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Panier",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profil",
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      onTap: (index) => widget.handleNavigation(index),
    );
  }
}