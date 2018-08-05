import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Item.dart';
import 'Strings.dart';
import 'Styles.dart';
import 'Urls.dart';

Future<List<Item>> fetchItems(http.Client client, String province) async {
  final response =
      await client.get(BASE_URL + province + '/produkty_mleczne.json');

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseItems, response.body);
}

List<Item> parseItems(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Item>((json) => Item.fromJson(json)).toList();
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
        title: Text(province, style: titleStyle),
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchItems(http.Client(), removePolishChars(province)),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(items: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Item> items;
  final TextStyle _biggerFont = const TextStyle(fontSize: 16.0);

  PhotosList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length * 2,
        itemBuilder: (BuildContext _context, int i) {
          if (i == 0) {
            return _buildRowTitle("produkty mleczne");
          }
          if (i.isEven) {
            return new Divider();
          }

          if (i == 0) {}
          final int index = i ~/ 2;

          return _buildRow(items[index]);
        });
  }

  Widget _buildRow(Item item) {
    return new ListTile(
      title: new Text(
        item.name,
        style: _biggerFont,
      ),
    );
  }

  Widget _buildRowTitle(String pair) {
    return new ListTile(
      title: new Text(
        pair,
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
