import '/models/post.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Api_Request{
  String inputtedWord;

  Api_Request(this.inputtedWord);


  Future<List<Post>?> getPosts() async{
    var client = http.Client();

    var uri = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$inputtedWord');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
 
    }
    return null;
  }
}