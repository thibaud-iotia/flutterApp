import 'package:flutter/material.dart';

class DialogBox {
  static Future<void> show(BuildContext context, VoidCallback onDeleteConfirmed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Pour empêcher la fermeture de la boîte de dialogue en appuyant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Voulez-vous vraiment supprimer cette activité ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                onDeleteConfirmed(); // Appeler la fonction de suppression
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: const Text("Supprimer"),
            ),
          ],
        );
      },
    );
  }
}
