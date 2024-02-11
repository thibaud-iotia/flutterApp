import 'package:flutter/material.dart';
import 'package:squadgather/Screens/HomeScreen.dart';
import 'package:squadgather/Screens/SubscribeScreen.dart';
import 'package:squadgather/Services/FirestoreService.dart';
import 'package:squadgather/utils/InputWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String _login = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();

  void onLoginChanged(String value) {
    setState(() {
      _login = value;
    });
    _formKey.currentState!.validate();
  }

  void onPasswordChanged(String value) {
    setState(() {
      _password = value;
    });
    _formKey.currentState!.validate();
  }

  void onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      bool logged = await _firestoreService.signIn(_login, _password);
      if (context.mounted) {
        if (logged) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        title: widget.title,
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login or password incorrect')),
          );
        
        }
      }
    } else {
      // If the form is invalid, display a snackbar.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Data')),
      );
    }
  }

  void handleSubscribe() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SubscribeScreen(title: "S'inscrire")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(children: <Widget>[
            Expanded(
                child: Align(
                    alignment: Alignment.center, child: Text(widget.title))),
            ElevatedButton(
                onPressed: () => handleSubscribe(),
                child: const Text("S'inscrire"))
          ]),
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
                //padding top
                const Padding(padding: EdgeInsets.only(top: 10)),
                //button
                ElevatedButton(
                  onPressed: () => onLoginPressed(),
                  child: const Text("Se connecter"),
                ),
              ],
            ),
          ),
        ));
  }
}
