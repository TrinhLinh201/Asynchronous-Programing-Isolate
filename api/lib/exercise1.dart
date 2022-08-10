import 'dart:convert';

import 'package:http/http.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> jsonObject) {
    return Post(jsonObject["userId"] as int, jsonObject["id"] as int,
        jsonObject["title"] as String, jsonObject["body"] as String);
  }
}

Map<String, dynamic> convertFromJsonToObject(String jsonString) {
  final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
  return jsonObject;
}

Future<Post> getPostFromBackend() async {
  final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/3");
  try {
    final response = await get(uri);
    final jsonString = response.body;
    final jsonObject = convertFromJsonToObject(jsonString);
    final post = Post.fromJson(jsonObject);
    return post;
  } catch (e) {
    print(e);
    rethrow;
  }
}

void doSomething() async {
  Post post = await getPostFromBackend();
  print(post.title);
}

// void main(List<String> args) {
//   doSomething();
// }
