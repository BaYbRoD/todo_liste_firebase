import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_liste_firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo Liste'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Login"),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: 'email@email.com',
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {},
                    validator: (value) {
                      return value!.isEmpty ? "Plase entre email" : null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: 'Password',
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {},
                    validator: (value) {
                      return value!.isEmpty ? "Plase entre email" : null;
                    },
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {},
                    child: const Text('login'),
                    color: Colors.amber,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
