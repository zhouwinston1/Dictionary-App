import 'package:flutter/material.dart';
import 'wordscreen.dart';

List<String> wordBank = [];

// ignore: must_be_immutable
class ListScreen extends StatefulWidget {
  final Map<String, dynamic> wordList;

  // Constructor for ListScreen
  ListScreen({required this.wordList});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _removeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.wordList.isNotEmpty) {
      for (var key in widget.wordList.keys) {
        if (!wordBank.contains(widget.wordList[key]) &&
            widget.wordList[key] != '1') {
          wordBank.add(widget.wordList[key]);
        }
      }
    }

    // wordBank.add(WordBankInfo());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word List'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
                    controller: _removeController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your word',
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                  ],
                );
              });
        },
        tooltip: 'Add a word',
        child: const Icon(Icons.remove),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: wordBank.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SelectedWordScreen(chosenWord: wordBank[index])));
              },
              title: Text(wordBank[index]),
              subtitle: const Text('Not Decided'),
              trailing: const Icon(Icons.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}
