import 'package:flutter/material.dart';
import 'package:squadgather/Models/User.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/AutoCompleteInput.dart';
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
          bool logged = await _firestoreService.signUp(currentUser);
          if (context.mounted) {
            if (logged) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subscribe sucessfull, you can now log in'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subscribe failed, please try again later'),
                ),
              );
            }
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Error while getting the next user id, please try again later'),
              ),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwords do not match, please try again later'),
            ),
          );
        }
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 10)),
                InputWidget(
                    labelText: "Login",
                    icon: Icons.person,
                    obscureText: false,
                    onChanged: onLoginChanged,
                    type: TextInputType.text),
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
                AutoCompleteInput(
                    label: "Adresse",
                    onSelected: onAdresseChanged,
                    icon: Icons.map),
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
                const Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                  onPressed: () => onSubscribePressed(),
                  child: const Text("S'inscrire"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
