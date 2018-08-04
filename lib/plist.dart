import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

TextStyle titleStyle = new TextStyle(
    color: Colors.black,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 22.0);

Future<Post> fetchPost() async {
  final response =
  await http.get('https://produkty-regionalne.firebaseio.com/wojewodztwa/dolnoslaskie.json');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String name;

  Post({this.name});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
    );
  }
}

class PList extends StatelessWidget {
  final String province;

  PList({Key key, @required this.province}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(province,
          style: titleStyle),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.name);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}