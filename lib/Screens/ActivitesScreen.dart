import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/ActivitiesList.dart';

class ActivitesScreen extends StatefulWidget {
  const ActivitesScreen({super.key, required this.title});

  final String title;

  @override
  State<ActivitesScreen> createState() => _ActivitesScreenState();
}

class _ActivitesScreenState extends State<ActivitesScreen> {

  final FirestoreService _firestoreService = FirestoreService();

  List<Activity> activitiesList = [];

  void getActivities(){
    _firestoreService.getActivities().then((value) => {
      setState(() {
        activitiesList = value;
      })
    });
  }
  
  @override
  void initState() {
    super.initState();
    getActivities();
  }

  @override
  Widget build(BuildContext context) {
    //display a text in the center of the screen
    return Column(
      children: <Widget> [
        Expanded(child: ActivitiesList(activitiesList: activitiesList)),
      ]
    );
  }
}
