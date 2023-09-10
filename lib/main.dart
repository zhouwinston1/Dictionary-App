import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'models/navbar.dart';
import 'package:firebase_core/firebase_core.dart';

Map<String, dynamic> myInitMap = {};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: prefer_const_constructors
  runApp(dictionary_app());
}

// ignore: camel_case_types
class dictionary_app extends StatelessWidget {
  const dictionary_app({super.key});

Future<Map<String, dynamic>?> getDataOnce() async {
  final database = FirebaseDatabase.instance.reference();
    final snapshot = await database.child('wordList').get();
    if (snapshot.exists) {
      var data = snapshot.value;
      if (data is Map) {
        for (var key in data.keys) {
          myInitMap[key] = data[key];
        }
      }
    } else {
      return {};
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    getDataOnce();
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomePage(inputList: myInitMap),
    );
  }
}