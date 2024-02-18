import 'package:flutter/material.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Screens/HomeScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/InputWidget.dart';
import 'package:image_input/image_input.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key, required this.title});

  final String title;

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  Activity newActivity = Activity(
      id: -999,
      titre: "",
      lieu: "",
      prix: -999,
      image: "",
      categorie: "",
      nbParticipants: 0);

  void handleTitreChanged(String value) {
    setState(() {
      newActivity.titre = value;
    });
  }

  void handleLieuChanged(String value) {
    setState(() {
      newActivity.lieu = value;
    });
  }

  void handleCategorieChanged(String value) {
    setState(() {
      newActivity.categorie = value;
    });
  }

  void handleNbParticipantsChanged(String value) {
    setState(() {
      newActivity.nbParticipants = int.parse(value);
    });
  }

  void handlePrixChanged(String value) {
    setState(() {
      newActivity.prix = int.parse(value);
    });
  }

  void onSubscribePressed() async {
    if (_formKey.currentState!.validate()) {
      int activityId = await _firestoreService.getNextActivityId();
      newActivity.id = activityId;
      bool activityAdded = await _firestoreService.addActivity(newActivity);
      if (context.mounted) {
        if (activityAdded) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(title: "SquadGather")));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${newActivity.titre} a bien été ajouté !'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${newActivity.titre} n'a pas pu être ajouté"),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InputWidget(
                      labelText: "Titre",
                      icon: Icons.local_activity,
                      obscureText: false,
                      onChanged: handleTitreChanged,
                      type: TextInputType.text),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  InputWidget(
                      labelText: "Lieu",
                      icon: Icons.place,
                      obscureText: false,
                      onChanged: handleLieuChanged,
                      type: TextInputType.text),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  ImageInput(
                    allowEdit: true,
                    allowMaxImage: 5,
                    onImageSelected: (image, index) {
                      //save image to cloud and get the url
                      //or
                      //save image to local storage and get the path
                      String? tempPath = image.path;
                      print(tempPath);
                    },
                  ),
                  InputWidget(
                      labelText: "Catégorie",
                      icon: Icons.category,
                      obscureText: false,
                      onChanged: handleCategorieChanged,
                      type: TextInputType.text),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  InputWidget(
                      labelText: "Nombre de participants",
                      icon: Icons.person,
                      obscureText: false,
                      onChanged: handleNbParticipantsChanged,
                      type: TextInputType.number),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  InputWidget(
                      labelText: "Prix",
                      icon: Icons.price_change,
                      obscureText: false,
                      onChanged: handlePrixChanged,
                      type: TextInputType.number),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  //button
                  ElevatedButton(
                    onPressed: () => onSubscribePressed(),
                    child: const Text("Ajouter"),
                  ),
                ]),
          )),
    );
  }
}
