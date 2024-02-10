import 'package:flutter/material.dart';
import 'package:squadgather/Screens/ActivitesScreen.dart';
import 'package:squadgather/Screens/ProfilScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/BottomNavBar.dart';
import 'package:squadgather/utils/TabBarTool.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Widget _currentScreen = const ActivitesScreen(title: "Activités");
  final FirestoreService _firestoreService = FirestoreService();

  bool showOptions = false;

  void handleTerminer() {
    _firestoreService.updateUser(_firestoreService.getCurrentUser());
    //close the keyboard
    FocusScope.of(context).unfocus();
  }

  void handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        setState(() {
          _currentScreen = const ActivitesScreen(title: "Activités");
          showOptions = false;
        });
        break;
      case 1:
        setState(() {
          _currentScreen = const TabBarTool();
          showOptions = false;
        });
        break;
      case 2:
        setState(() {
          _currentScreen = const ProfilScreen(title: "Mon profil");
          showOptions = true;
        });
        break;
      default:
        setState(() {
          _currentScreen = const ActivitesScreen(title: "Activités");
          showOptions = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: showOptions ? Row(children: <Widget>[
            Expanded(child: Align(alignment: Alignment.center, child: Text(widget.title))),
            ElevatedButton(onPressed: () => handleTerminer(), child: const Text("Terminer"))
          ]) : Text(widget.title),
        ),
        body: _currentScreen,
        bottomNavigationBar: BottomNavBar(handleNavigation: handleNavigation, currentIndex: _currentIndex,));
  }
}
