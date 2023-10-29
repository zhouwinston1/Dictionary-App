import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';

List<String> readDataToList = [];

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController removeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: const Text(
                            'Remove a word from your list',
                            style: TextStyle(fontSize: 10),
                          ),
                          content: TextField(
                            controller: removeController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your word',
                            ),
                          ),
                          actions: <Widget>[
                            ButtonBar(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    final database = FirebaseDatabase.instance.reference();
                                    final databaseWords = database.child('wordList');
                                    databaseWords.child(removeController.text).remove();
                                    myMap.remove(removeController.text);
                                    Navigator.of(context).pop();
                                    removeController.clear();
                              
                                  },
                                  child: const Text('Remove'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Edit List"))
            ],
          ),
        ),
      ),
    );
  }
}
