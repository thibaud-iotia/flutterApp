import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Services/FirestoreService.dart';

class CurrentActivityScreen extends StatefulWidget {
  const CurrentActivityScreen({super.key, required this.activity});

  final Activity activity;

  @override
  State<CurrentActivityScreen> createState() => _CurrentActivityScreenState();
}

class _CurrentActivityScreenState extends State<CurrentActivityScreen> {

  final FirestoreService _firestoreService = FirestoreService();


  void handleAddActivityToCart() {
    _firestoreService.addActivityToCart(widget.activity.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity.titre),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.activity.titre,
            ),
            Text(widget.activity.categorie),
            Text('${widget.activity.prix}€'),
            Text(widget.activity.lieu),
            Text('Nombre maximum de participants: ${widget.activity.nbParticipants}'),
            Image.network(
              widget.activity.image,
              height: 100,
              width: 100,
            ),
            ElevatedButton(onPressed: () => handleAddActivityToCart(), child: Text("Ajouter au panier")),
          ],
        ),
      ),
    );
  }
}