import 'package:flutter/material.dart';
import 'models/navbar.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: prefer_const_constructors
  runApp(dictionary_app());
}

// ignore: camel_case_types
class dictionary_app extends StatelessWidget {
  const dictionary_app({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomePage(inputList: const {'1': '1'}),
    );
  }
}