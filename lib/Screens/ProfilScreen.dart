import 'package:flutter/material.dart';
import 'package:squadgather/Models/User.dart';
import 'package:squadgather/Screens/LoginScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/InputWidget.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key, required this.title});

  final String title;

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  User currentUser = User(login: "", password: "", adress: "", city: "", birthday: "", postalCode: "", id: -999);


  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser = _firestoreService.getCurrentUser(); // recuperation de l'utilisateur courant lors de la connexion 
    });
  }
  void onPasswordChanged(String value) {
    setState(() {
      currentUser.password = value;
    });
    _formKey.currentState!.validate();
  }
  void onAnniversaireChanged(String value) {
    setState(() {
      currentUser.birthday = value;
    });
    _formKey.currentState!.validate();
  }
  void onAdresseChanged(String value) {
    setState(() {
      currentUser.adress = value;
    });
    _formKey.currentState!.validate();
  }
  void onCodePostalChanged(String value) {
    setState(() {
      currentUser.postalCode = value;
    });
    _formKey.currentState!.validate();
  }
  void onVilleChanged(String value) {
    setState(() {
      currentUser.city = value;
    });
    _formKey.currentState!.validate();
  }

  void handleDisconnect(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(title: "SquadGather")));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              //text centrer 
              const Text("Mon profil", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputWidget(labelText: "Login", icon: Icons.person, obscureText: false, readOnly: true, currentValue: currentUser.login, type: TextInputType.text),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputWidget(labelText: "Password", icon: Icons.lock, obscureText: true, onChanged: onPasswordChanged, currentValue: currentUser.password, type: TextInputType.text),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputWidget(labelText: "Anniversaire", icon: Icons.date_range, obscureText: false, onChanged: onAnniversaireChanged, currentValue: currentUser.birthday, type: TextInputType.datetime),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputWidget(labelText: "Adresse", icon: Icons.map, obscureText: false, onChanged: onAdresseChanged, currentValue: currentUser.adress, type: TextInputType.text),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputWidget(labelText: "Code Postal", icon: Icons.local_post_office, obscureText: false, onChanged: onCodePostalChanged, currentValue: currentUser.postalCode, type: TextInputType.number),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InputWidget(labelText: "Ville", icon: Icons.location_city, obscureText: false, onChanged: onVilleChanged, currentValue: currentUser.city, type: TextInputType.text),
              ElevatedButton(onPressed: () => handleDisconnect(), child: 
                const Text("Se deconnecter")
              ),
            ],
          ),
        )
      ));
  }
}
