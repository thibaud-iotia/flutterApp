import 'package:flutter/material.dart';
import 'package:squadgather/Screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  CloudinaryContext.cloudinary = 
    Cloudinary.fromCloudName(cloudName: "dvitd89f9");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SquadGather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 203, 184, 101)),
        useMaterial3: true,
      ),
      home: const LoginScreen(title: 'SquadGather'),
    );
  }
}
