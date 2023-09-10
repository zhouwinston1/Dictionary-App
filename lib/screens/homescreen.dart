import '/models/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> myMap = {};



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _wordController = TextEditingController();
  final database = FirebaseDatabase.instance.reference();

  

  @override
  Widget build(BuildContext context) {
    final databaseWords = database.child('wordList');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.grey.shade300,
      ),
      body: const SafeArea(
        child: Column(
          children: [
            SizedBox(height: 200),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show a dialog to input the word.
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Adjust the value as needed
                ),
                title: const Text(
                  'Add a word to your list',
                  style: TextStyle(fontSize: 10),
                ),
                content: TextField(
                  controller: _wordController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your word',
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () async {

                      myMap[_wordController.text] = _wordController.text;

                      final snapshot = await database.child('wordList').get();
                      if (snapshot.exists) {
                        var data = snapshot.value;
                        if (data is Map) {
                          for (var key in data.keys) {
                            myMap[key] = data[key];
                          }
                        }
                      }

                      databaseWords.set(myMap);
                      _wordController.clear();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(inputList: myMap),
                        ),
                      );
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add a word',
        child: const Icon(Icons.add),
      ),
    );
  }
}
