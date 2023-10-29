import '/models/post.dart';
import '/services/api_request.dart';
import 'package:flutter/material.dart';

class SelectedWordScreen extends StatefulWidget {
  final String chosenWord;

  const SelectedWordScreen({
    Key? key,
    required this.chosenWord,
  }) : super(key: key);

  @override
  State<SelectedWordScreen> createState() => _SelectedWordScreenState();
}

class _SelectedWordScreenState extends State<SelectedWordScreen> {
  List<Post>? posts;
  var isLoaded = false;

  getData(chosenWord) async {
    posts = await Api_Request(chosenWord).getPosts();

    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Widget _buildBody() {
    if (!isLoaded) {
      return const Center(child: CircularProgressIndicator());
    } else if (posts == null || posts!.isEmpty) {
      return const Center(child: Text('No data available.'));
    } else {
      // Display the fetched data here
      return ListView.builder(
        itemCount: posts!.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.black,
            margin: const EdgeInsets.symmetric(
                vertical: 10.0), // Adjust the value as needed
            child: Padding(
              padding: const EdgeInsets.all(5.0), // Adjust the value as needed
              child: ListTile(
                title: Text(
                  posts![index].word,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  posts![index].meanings[0].definitions[0].definition,
                  style: const TextStyle(color: Colors.white,
                  fontSize: 15),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData(widget.chosenWord); // Fetch data when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      appBar: AppBar(
        title: Text(
          widget.chosenWord,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: _buildBody(),
    );
  }
}
