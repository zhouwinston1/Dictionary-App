import 'package:dictionary_app/main.dart';
import 'package:dictionary_app/screens/homescreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'wordscreen.dart';

List<String> wordBank = [];
List<String> readDataToList = [];
Map<String, dynamic> readData = {};
int whereToReceiveData = 1;

// ignore: must_be_immutable
class ListScreen extends StatefulWidget {
  final Map<String, dynamic> wordList;

  // Constructor for ListScreen
  ListScreen({required this.wordList});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Future<Map<String, dynamic>?> getDataOnce() async {
    final database = FirebaseDatabase.instance.reference();
    final snapshot = await database.child('wordList').get();
    if (snapshot.exists) {
      var data = snapshot.value;
      if (data is Map) {
        for (var key in data.keys) {
          readData[key] = data[key];
        }
      }
      for (var value in readData.values) {
        if (!readDataToList.contains(value)) {
          readDataToList.add(value);
        }
      }
    } else {
      return {};
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    readDataToList = [];
    if (whereToReceiveData++ == 1) {
      print(1);
      for (var value in myInitMap.values) {
        if (!readDataToList.contains(value)) {
          print(value + 'init');
          readDataToList.add(value);
          if (!myMap.containsValue(value)) {
            myMap[value] = value;
          }
        }
      }
    } else {
      print(2);
      for (var value in myMap.values) {
        if (!readDataToList.contains(value)) {
          readDataToList.add(value);
          print(value);
        }
      }
    }

    print(readDataToList);

    // if (widget.wordList.isNotEmpty) {
    //   for (var key in widget.wordList.keys) {
    //     if (!wordBank.contains(widget.wordList[key]) &&
    //         widget.wordList[key] != '1') {
    //       wordBank.add(widget.wordList[key]);
    //     }
    //   }
    // }

    // wordBank.add(WordBankInfo());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word List'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await showDialog(
      //         context: context,
      //         builder: (context) {
      //           return AlertDialog(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(10.0),
      //             ),
      //             title: const Text(
      //               'Remove a word from your list',
      //               style: TextStyle(fontSize: 10),
      //             ),
      //             content: TextField(
      //               controller: _removeController,
      //               decoration: const InputDecoration(
      //                 labelText: 'Enter your word',
      //               ),
      //             ),
      //             actions: <Widget>[
      //               ElevatedButton(
      //                 onPressed: () {
      //                   final database = FirebaseDatabase.instance.reference();
      //                   final databaseWords = database.child('wordList');
      //                   databaseWords.child(_removeController.text).remove();
      //                   myMap.remove(_removeController.text);
      //                   readDataToList.remove(_removeController.text);
      //                   Navigator.of(context).pop();
      //                   _removeController.clear();
      //                 },
      //                 child: const Text('Remove'),
      //               ),
      //             ],
      //           );
      //         });
      //   },
      //   tooltip: 'Add a word',
      //   child: const Icon(Icons.remove),
      // ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: readDataToList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SelectedWordScreen(chosenWord: readDataToList[index])));
              },
              title: Text(readDataToList[index]),
              subtitle: const Text('Not Decided'),
              trailing: const Icon(Icons.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}
