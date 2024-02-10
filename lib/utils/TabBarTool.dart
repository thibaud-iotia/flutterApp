import 'package:flutter/material.dart';
import 'package:squadgather/Screens/PanierScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';

class TabBarTool extends StatefulWidget {
  const TabBarTool({super.key});

  @override
  State<TabBarTool> createState() => _TabBarToolState();
}

class _TabBarToolState extends State<TabBarTool> {
  final FirestoreService _firestoreService = FirestoreService();

  final List<Widget> _tabList = [];

  String title = "Toutes les catégories";

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabList.add(const PanierScreen(title: "Mon panier"));
      _firestoreService.getCategorie().forEach((element) {
        _tabList.add(PanierScreen(title: "Mon panier", category: element));
      });
    });
  }

  void handleTabChange(int index) {
    setState(() {
      title = index == 0 ? "Toutes les catégories" : _firestoreService.getCategorie()[index - 1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context), // Use the theme from the ancestor MaterialApp
      child: DefaultTabController(
        length: _tabList.length,
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
              ],
            ),
          ),
          body: TabBarView(
            children: _tabList,
          ),
        ),
      ),
    );
  }
}
