import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Strings.dart';
import 'Styles.dart';
import 'Urls.dart';

Future<List<String>> fetchDetail(http.Client client, String province) async {
  final response = await client.get(BASE_URL_DETAILS + province + '.json');

  return compute(parseItems, response.body);
}

List<String> parseItems(String responseBody) {
  final parsed = json.decode(responseBody);

  List<String> details = [];

  for (int i = 0; i < detailTags.length; i++) {
    if (parsed[detailTags[i]] != null) {
      if (parsed[detailTags[i]].toString().isNotEmpty) {
        if (i != 0) {
          details.add(detailTitles[i]);
        }
        details.add(parsed[detailTags[i]]);
      }
    }
  }

  details.add(parsed['category']);

  return details;
}

class PDetails extends StatelessWidget {
  final String url;
  final String name;

  PDetails({Key key, @required this.url, @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(name, style: titleStyle),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchDetail(http.Client(), url),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? DetailList(details: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class DetailList extends StatelessWidget {
  final List<String> details;

  DetailList({Key key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        itemCount: details.length - 1,
        itemBuilder: (BuildContext _context, int i) {
          if (i == 0) {
            return _buildTile(details[i], details[details.length - 1]);
          }
          if (i.isOdd) {
            return _buildRowTitle(details[i]);
          } else {
            return _buildRow(details[i]);
          }
        });
  }

  Widget _buildTile(String title, String image) {
    return new ListTile(
      leading: Image.asset(
        'assets/images/' + image + '.png',
        width: 40.0,
        height: 40.0,
      ),
      title: new Text(
        title,
        style: listFont,
      ),
    );
  }

  Widget _buildRowTitle(String pair) {
    return new ListTile(
      title: new Text(
        pair,
        style: rowStyle,
      ),
    );
  }

  Widget _buildRow(String pair) {
    return new ListTile(
      title: new Text(
        pair,
      ),
    );
  }
}
