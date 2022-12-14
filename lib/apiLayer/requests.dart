import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'key.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../data/models.dart';




Future<List<Post>> getpost(http.Client client,int page) async {
  final response = await client.get(
    Uri.parse('https://dummyapi.io/data/v1/post?page=$page&limit=20'),
    headers:<String, String>{
      'app-id':API_KEY,
    },
  );
  return compute(parsePosts,response.body);
}


List<Post> parsePosts(String responseBody){

  final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}



Future<List<Post>> searchList(http.Client client,int p,String tag) async {
  final response = await client.get(
    Uri.parse('https://dummyapi.io/data/v1/tag/$tag/post?page=$p&limit=10'),
    headers:<String, String>{
      'app-id':API_KEY,
    },
  );
  return compute(parseList,response.body);

}

List<Post> parseList(String responseBody){

  final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}


Future<Post> deletePost(String id) async {
  final response= await http.delete(
      Uri.parse('https://dummyapi.io/data/v1/post/$id'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'app-id':API_KEY
      }
  );

  if (response.statusCode == 200) {
    Fluttertoast.showToast(msg:'post deleted');
    return Post.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg:'failed to delet post!');
    throw Exception('');
  }
}

Future<bool> createPost(String txt,String image,List<dynamic> tags) async {
    final response = await http.post(

      Uri.parse('https://dummyapi.io/data/v1/post/create'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'app-id':'625c0856d26a27189d6ccd26',
      },
      body: jsonEncode(<String, dynamic>{
        'text':txt,
        'image':image,
        'likes':0,
        'tags':tags,
        'owner':'60d0fe4f5311236168a109ca'
      }),
    );
    if (response.statusCode == 200) {
      
      Fluttertoast.showToast(msg:'post added');
      return true;// Post.fromJson(jsonDecode(response.body));
    } else {

      throw Exception('Failed to create album.');
    }
}

Future<Post> liked(String id,int like) async {
  final response= await http.put(
      Uri.parse('https://dummyapi.io/data/v1/post/$id'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'app-id':API_KEY
      },
    body:jsonEncode(<String, dynamic>{
    'likes': like,
  }),
  );

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('');
  }
}

