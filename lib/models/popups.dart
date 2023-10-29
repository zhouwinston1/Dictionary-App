import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../screens/wordscreen.dart';
import 'navbar.dart';

void showAboutAppDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('About the App'),
        content: const Text(
          "This app is designed for you to remember words that just can't stick in your mind. With this app's assistance, words are much more accessible for you to remember, improving how long the words will stay in your mind's dictionary. \n\nTo add a word, press the plus icon. To remove a word, hold onto the word you would like to be deleted. To search for a word, press the magnifying glass icon.",
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

Future<void> showWordInputDialog(
    BuildContext context,
    TextEditingController _wordController,
    Map<String, dynamic> myMap,
    DatabaseReference database,
    DatabaseReference databaseWords) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
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
}

void showSearchDialog(BuildContext context, TextEditingController searchController, List<String> readDataToList) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: const Text(
          'Search for a word in your list',
          style: TextStyle(fontSize: 10),
        ),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Enter your word',
          ),
        ),
        actions: <Widget>[
          ButtonBar(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  String searchWord = searchController.text;
                  if (readDataToList.contains(searchWord)) {
                    // Word found, navigate to SelectedWordScreen
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SelectedWordScreen(chosenWord: searchWord),
                    ));
                  } else {
                    // Word not found, show a popup
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Word Not Found'),
                          content: const Text(
                            'The word you searched for is not in your list.',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Search'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
