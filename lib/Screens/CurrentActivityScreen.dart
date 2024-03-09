import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Screens/HomeScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/InputWidget.dart';

class CurrentActivityScreen extends StatefulWidget {
  const CurrentActivityScreen({
    super.key,
    required this.activity,
    required this.isEditing,
  });

  final Activity activity;
  final bool isEditing;

  @override
  State<CurrentActivityScreen> createState() => _CurrentActivityScreenState();
}

class _CurrentActivityScreenState extends State<CurrentActivityScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  void handleAddActivityToCart() async {
    if (widget.isEditing) {
      bool isUpdated = await _firestoreService.updateActivity(widget.activity);
      if (isUpdated) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Activité ${widget.activity.titre} mise à jour !')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen(title: "SquadGather")),
          );
        }
      }
    } else {
      _firestoreService.addActivityToCart(widget.activity.id);
    }
  }

  void handleCategoryChanged(String value) {
    setState(() {
      widget.activity.categorie = value;
    });
  }

  void handleLieuChanged(String value) {
    setState(() {
      widget.activity.lieu = value;
    });
  }

  void handlePrixChanged(String value) {
    setState(() {
      widget.activity.prix = int.parse(value);
    });
  }

  void handleNbParticipantsChanged(String value) {
    setState(() {
      widget.activity.nbParticipants = int.parse(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity.titre),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (widget.isEditing)
              InputWidget(
                labelText: "Nouvelle catégorie : ",
                icon: Icons.category,
                obscureText: false,
                readOnly: false,
                currentValue: widget.activity.categorie,
                onChanged: handleCategoryChanged,
                type: TextInputType.text,
              )
            else
              Text("Catégorie: ${widget.activity.categorie}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            if (widget.isEditing)
              InputWidget(
                labelText: "Nouveau prix : ",
                icon: Icons.price_change,
                obscureText: false,
                readOnly: false,
                currentValue: widget.activity.prix.toString(),
                onChanged: handlePrixChanged,
                type: TextInputType.number,
              )
            else
              Text("Prix : ${widget.activity.prix}€", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            if (widget.isEditing)
              InputWidget(
                labelText: "Nouveau lieu",
                icon: Icons.place,
                obscureText: false,
                readOnly: false,
                currentValue: widget.activity.lieu,
                onChanged: handleLieuChanged,
                type: TextInputType.text,
              )
            else
              Text("Lieu: ${widget.activity.lieu}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            if (widget.isEditing)
              InputWidget(
                labelText: "Nouveau nb de participants",
                icon: Icons.people,
                obscureText: false,
                readOnly: false,
                currentValue: widget.activity.nbParticipants.toString(),
                onChanged: handleNbParticipantsChanged,
                type: TextInputType.number,
              )
            else
              Text("Nombre maximum de participants: ${widget.activity.nbParticipants}",
                  style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Image.network(
              widget.activity.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleAddActivityToCart(),
              child: Text(widget.isEditing ? "Enregistrer" : "Ajouter au panier"),
            ),
          ],
        ),
      ),
    );
  }
}
