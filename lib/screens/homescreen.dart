import 'package:dictionary_app/models/fetchdata.dart';
import 'package:dictionary_app/models/popups.dart';
import '/models/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'wordscreen.dart';

Map<String, dynamic> myMap = {};
List<String> readDataToList = [];
int whereToReceiveData = 1;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    readDataToList = [];
    var databaseWords = database.child('wordList');
    fetchDataFromDatabase(myMap, readDataToList, whereToReceiveData);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: IconButton(
            onPressed: () {
              // Show a pop-up dialog with information about the app.
              showAboutAppDialog(context);
            },
            icon: const Icon(
              Icons.help_rounded,
              color: Colors.white,
            ),
          ),
        ),
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            'App Name',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 4,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0.0, top: 30),
            child: IconButton(
              onPressed: () {
                showSearchDialog(context, searchController, readDataToList);
              },
              icon: const Icon(Icons.search),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 30),
            child: IconButton(
              onPressed: () async {
                // Show a dialog to input the word.
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the value as needed
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

                            final snapshot =
                                await database.child('wordList').get();
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
                                builder: (context) =>
                                    HomePage(inputList: myMap),
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
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: readDataToList.length,
              itemBuilder: (context, index) {
                // Add 1 to the index to display 1-based numbering
                final wordNumber = index + 1;
                return Card(
                  color: const Color.fromARGB(255, 15, 15, 15),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectedWordScreen(
                              chosenWord: readDataToList[index])));
                    },
                    leading: CircleAvatar(
                      radius: 10,
                      backgroundColor:
                          Colors.black, // Customize the background color
                      child: Text(
                        '$wordNumber',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold), // Customize the text color
                      ),
                    ),
                    title: Text(
                      readDataToList[index],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
