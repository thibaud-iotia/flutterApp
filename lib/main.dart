import 'package:flutter/material.dart';
import 'package:squadgather/Screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Cloudinary cloudinary = Cloudinary.fromCloudName(cloudName: "dvitd89f9");
  runApp(MyApp(cloudinary: cloudinary));
}

class MyApp extends StatelessWidget {
  final Cloudinary cloudinary;

  const MyApp({super.key, required this.cloudinary});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SquadGather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 203, 184, 101)),
        useMaterial3: true,
      ),
      home: const LoginScreen(title: 'SquadGather'),
      builder: EasyLoading.init(),
    );
  }
}
