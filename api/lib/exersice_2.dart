import 'dart:convert';

import 'package:http/http.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> jsonObject) {
    return Post(jsonObject['userId'] as int, jsonObject["id"] as int,
        jsonObject['title'] as String, jsonObject['body'] as String);
  }
  void showInf() {
    print("[userId: ${this.userId},");
    print("id: ${this.id},");
    print("title: ${this.title},");
    print("body: ${this.body}]");
  }
}

List<dynamic> convertFromJsonToListOfObjects(String jsonString) {
  List<dynamic> jsonListObject = jsonDecode(jsonString);
  jsonListObject[2];
  return jsonListObject;
}

List<Post> convertToPostList(List<dynamic> jsonListObject) {
  List<Post> postList = [];
  for (var element in jsonListObject) {
    postList.add(Post.fromJson(element));
  }
  return postList;
}

Future<List<Post>> getListPostToBackend() async {
  try {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await get(uri);
    final jsonString = response.body;
    final jsonListObject = convertFromJsonToListOfObjects(jsonString);
    final postList = convertToPostList(jsonListObject);
    return postList;
  } catch (e) {
    print("lỗi r");
    rethrow;
  }
}

void doSomething() async {
  List<Post> listPost = await getListPostToBackend();
  print(listPost[3].body);
  for (var element in listPost) {
    element.showInf();
  }
}

void main() {
  doSomething();
}
