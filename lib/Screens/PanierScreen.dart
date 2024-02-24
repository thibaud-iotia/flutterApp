import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/PanierList.dart';

class PanierScreen extends StatefulWidget {
  final String? category;
  const PanierScreen({super.key, required this.title, this.category});

  final String title;

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  FirestoreService firestoreService = FirestoreService();

  List<Activity> activites = [];
  int total = 0;

  void deleteActivityFromCart(int id) {
    firestoreService.removeActivityFromCart(id);
    setState(() {
      activites.removeWhere((element) => element.id == id);
    });
    updateTotal();
  }

  void updateTotal() {
    setState(() {
      total = 0;
      activites.forEach((element) {
        total += element.prix;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    firestoreService.getActivitiesFromCart(category: widget.category).then((value) => {
      setState(() {
        activites = value;
        updateTotal();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PanierList(
            panierList: activites,
            deleteActivityFromCart: deleteActivityFromCart,
          ),
        ),
        Text(
          "Total : $total €",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Vous pouvez modifier la couleur selon votre préférence
          ),
        )
      ],
    );
  }
}
