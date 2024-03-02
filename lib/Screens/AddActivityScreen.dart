import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:squadgather/Models/Activity.dart';
import 'package:squadgather/Screens/HomeScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/DropDownList.dart';
import 'package:squadgather/utils/InputWidget.dart';
import 'package:image_input/image_input.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

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
  bool isImageSelected = false;
  bool isImageUploaded = false;

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
      if (!isImageSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner une image'),
          ),
        );
        return;
      }
      int activityId = await _firestoreService.getNextActivityId();
      newActivity.id = activityId;
      bool activityAdded = await _firestoreService.addActivity(newActivity);
      if (context.mounted) {
        if (activityAdded) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const HomeScreen(title: "SquadGather")));
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
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      await Permission.photos.request();
    }
  }

  Future<void> handleAddImage(XFile image, int index) async {
    EasyLoading.show(status: 'Chargement...');
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dvitd89f9/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'zieahaqu'
      ..files.add(await http.MultipartFile.fromPath('file', image.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jasonMap = jsonDecode(responseString);
      final url = jasonMap['url'];
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          newActivity.image = url;
          isImageSelected = true;
        });
      }
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        EasyLoading.dismiss();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  InputWidget(
                    labelText: "Titre",
                    icon: Icons.local_activity,
                    obscureText: false,
                    onChanged: handleTitreChanged,
                    type: TextInputType.text,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  InputWidget(
                    labelText: "Lieu",
                    icon: Icons.place,
                    obscureText: false,
                    onChanged: handleLieuChanged,
                    type: TextInputType.text,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  ImageInput(
                    allowEdit: true,
                    allowMaxImage: 5,
                    onImageSelected: (image, index) =>
                        handleAddImage(image, index),
                  ),
                  newActivity.image != ""
                      ? Image.network(newActivity.image)
                      : const Text(""),
                  DropDownList(
                      list: _firestoreService.getCategorie(),
                      onChanged: handleCategorieChanged,
                      prefixIcon: Icons.category),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  InputWidget(
                    labelText: "Nombre de participants",
                    icon: Icons.person,
                    obscureText: false,
                    onChanged: handleNbParticipantsChanged,
                    type: TextInputType.number,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  InputWidget(
                    labelText: "Prix",
                    icon: Icons.price_change,
                    obscureText: false,
                    onChanged: handlePrixChanged,
                    type: TextInputType.number,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  //button
                  ElevatedButton(
                    onPressed: () => onSubscribePressed(),
                    child: const Text("Ajouter"),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
