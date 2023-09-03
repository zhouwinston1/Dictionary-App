import 'package:dictionary_app_matteo/models/post.dart';
import 'package:dictionary_app_matteo/services/api_request.dart';
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
            child: ListTile(
              title: Text(
                posts![index].word,
              ),
              subtitle: Text(posts![index].meanings[0].definitions[0].definition),
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
      appBar: AppBar(
        title: Text(widget.chosenWord),
      ),
      body: _buildBody(),
    );
  }
}
