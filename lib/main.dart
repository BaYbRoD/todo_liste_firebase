import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:todo_liste_firebase/firebase_options.dart';

Future<void> main() async {
  //await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
  //);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Firebase install!'),
        ),
      ),
    );
  }
}