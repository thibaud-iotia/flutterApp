import 'package:flutter/material.dart';
import 'package:squadgather/Screens/ActivitesScreen.dart';
import 'package:squadgather/Screens/PanierScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';

class TabBarTool extends StatefulWidget {
  const TabBarTool({super.key, required this.screenName});

  final String screenName;

  @override
  State<TabBarTool> createState() => _TabBarToolState();
}

class _TabBarToolState extends State<TabBarTool> {
  final FirestoreService _firestoreService = FirestoreService();

  String title = "Toutes les catégories";


  void handleTabChange(int index) {
    setState(() {
      title = index == 0 ? "Toutes les catégories" : _firestoreService.getCategorie()[index - 1];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabList = [];
    if (widget.screenName == "panier") {
      tabList.add(const PanierScreen(title: "Mon panier"));
      _firestoreService.getCategorie().forEach((element) {
        tabList.add(PanierScreen(title: "Mon panier", category: element));
      });
    } else {
      tabList.add(const ActivitesScreen(title: "Activités"));
      _firestoreService.getCategorie().forEach((element) {
        tabList.add(ActivitesScreen(title: "Activités", category: element));
      });
    }
    return Theme(
      data: Theme.of(context),
      child: DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(title),
            bottom: TabBar(
              onTap: (e) => handleTabChange(e),
              tabs: const [
                Tab(icon: Icon(Icons.all_inbox)),
                Tab(icon: Icon(Icons.hiking_rounded)),
                Tab(icon: Icon(Icons.local_activity)),
                Tab(icon: Icon(Icons.nightlife)),
                Tab(icon: Icon(Icons.all_inclusive)),
              ],
            ),
          ),
          body: TabBarView(
            children: tabList,
          ),
        ),
      ),
    );
  }
}
