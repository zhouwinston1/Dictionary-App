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
  @override
  Widget build(BuildContext context) {
    if (widget.wordList.isNotEmpty) {
      for (var key in widget.wordList.keys) {
        if (!wordBank.contains(widget.wordList[key]) && widget.wordList[key] != '1') {
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
