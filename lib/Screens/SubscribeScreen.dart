import 'package:flutter/material.dart';
import 'package:squadgather/Models/User.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/InputWidget.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key, required this.title});

  final String title;

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  String _confirmPassword = "";
  User currentUser = User(
      login: "",
      password: "",
      adress: "",
      city: "",
      birthday: "",
      postalCode: "",
      id: -999);
  final FirestoreService _firestoreService = FirestoreService();

  void onLoginChanged(String value) {
    setState(() {
      currentUser.login = value;
    });
  }

  void onPasswordChanged(String value) {
    setState(() {
      currentUser.password = value;
    });
  }

  void onConfirmPasswordChanged(String value) {
    setState(() {
      _confirmPassword = value;
    });
  }

  void onAnniversaireChanged(String value) {
    setState(() {
      currentUser.birthday = value;
    });
  }

  void onAdresseChanged(String value) {
    setState(() {
      currentUser.adress = value;
    });
  }

  void onCodePostalChanged(String value) {
    setState(() {
      currentUser.postalCode = value;
    });
  }

  void onVilleChanged(String value) {
    setState(() {
      currentUser.city = value;
    });
  }

  void onSubscribePressed() async {
    if (_formKey.currentState!.validate()) {
    if (currentUser.password == _confirmPassword) {
      int id = await _firestoreService.getNextUserId();
      if (id != -999) {
        currentUser.id = id;
        await _firestoreService.signUp(currentUser)
            ? Navigator.pop(context)
            : print("Subscribe failed");
      } else {
        print("Subscribe failed on getting next user id");
      }
    } else {
      print("Password and Confirm Password are not the same");
    }
    }
  }

  final _formKey = GlobalKey<FormState>();

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
                    labelText: "Login",
                    icon: Icons.person,
                    obscureText: false,
                    onChanged: onLoginChanged,
                    type: TextInputType.text),
                //padding top and bottom
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                InputWidget(
                    labelText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    onChanged: onPasswordChanged,
                    type: TextInputType.text),
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                InputWidget(
                    labelText: "Confirmer le password",
                    icon: Icons.lock,
                    obscureText: true,
                    onChanged: onConfirmPasswordChanged,
                    type: TextInputType.text),
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                InputWidget(
                    labelText: "Adresse",
                    icon: Icons.map,
                    obscureText: false,
                    onChanged: onAdresseChanged,
                    type: TextInputType.text),
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                InputWidget(
                    labelText: "Date de naissance",
                    icon: Icons.date_range,
                    obscureText: false,
                    onChanged: onAnniversaireChanged,
                    type: TextInputType.datetime),
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                InputWidget(
                    labelText: "Ville",
                    icon: Icons.location_city,
                    obscureText: false,
                    onChanged: onVilleChanged,
                    type: TextInputType.text),
                const Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                InputWidget(
                    labelText: "Code Postal",
                    icon: Icons.local_post_office,
                    obscureText: false,
                    onChanged: onCodePostalChanged,
                    type: TextInputType.number),
                //padding top
                const Padding(padding: EdgeInsets.only(top: 10)),
                //button
                ElevatedButton(
                  onPressed: () => onSubscribePressed(),
                  child: const Text("S'inscrire"),
                ),
              ],
            ),
          ),
        ));
  }
}
