import 'package:flutter/material.dart';
import 'package:squadgather/Screens/ActivitesScreen.dart';
import 'package:squadgather/Screens/AddActivityScreen.dart';
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
  String optionName = "Terminer";
  @override
  void initState(){
    super.initState();
    handleNavigation(0);
  }

  void handleOptions() {
    if (optionName == "Terminer"){
      _firestoreService.updateUser(_firestoreService.getCurrentUser());
      //close the keyboard
      FocusScope.of(context).unfocus();
      
    }else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddActivityScreen(title: "SquadGather")));
    }
  }

  void handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        setState(() {
          //_currentScreen = const ActivitesScreen(title: "Activités");
          _currentScreen = const TabBarTool(screenName: "activites");
          showOptions = true;
          optionName = "Ajouter";
        });
        break;
      case 1:
        setState(() {
          _currentScreen = const TabBarTool(screenName: "panier");
          showOptions = false;
          optionName = "Terminer";
        });
        break;
      case 2:
        setState(() {
          _currentScreen = const ProfilScreen(title: "Mon profil");
          showOptions = true;
          optionName = "Terminer";
        });
        break;
      default:
        setState(() {
          //_currentScreen = const ActivitesScreen(title: "Activités");
          _currentScreen = const TabBarTool(screenName: "activites");
          showOptions = false;
          optionName = "Terminer";
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
            ElevatedButton(onPressed: () => handleOptions(), child: Text(optionName))
          ]) : Text(widget.title),
        ),
        body: _currentScreen,
        bottomNavigationBar: BottomNavBar(handleNavigation: handleNavigation, currentIndex: _currentIndex,));
  }
}
