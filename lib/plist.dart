import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Item.dart';
import 'Strings.dart';
import 'Styles.dart';
import 'Urls.dart';
import 'pdetails.dart';

Future<ItemList> fetchItems(http.Client client, String province) async {
  final response = await client.get(BASE_URL + province + '.json');

  return compute(parseItems, response.body);
}

ItemList parseItems(String responseBody) {
  final parsed = json.decode(responseBody);

  List<Item> items = new List<Item>();

  for (int i = 0; i < categoryListForDownload.length; i++) {
    if (parsed[categoryListForDownload[i]] != null) {
      items.add(new Item(categoryListSmall[i], '', ''));
      for (var item in parsed[categoryListForDownload[i]]) {
        items.add(new Item(item['name'], item['url'], item['category']));
      }
    }
  }

  return new ItemList(items);
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
      body: FutureBuilder<ItemList>(
        future: fetchItems(http.Client(), removePolishChars(province)),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ItemsList(items: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ItemsList extends StatelessWidget {
  final ItemList items;

  ItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.products.length * 2,
        itemBuilder: (BuildContext _context, int i) {
          final int index = i ~/ 2;

          if (i.isOdd) {
            return new Divider();
          }

          for (var name in categoryListSmall) {
            if (items.products[index].name == name) {
              return _buildRowTitle(items.products[index].name);
            }
          }

          return _buildRow(items.products[index], context);
        });
  }

  Widget _buildRow(Item item, BuildContext context) {
    return new ListTile(
      onTap: () {
        // Add 9 lines from here...
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PDetails(url: item.url, name: item.name)),
        );
      },
      leading: Image.asset(
        'assets/images/' + item.category + '.png',
        width: 40.0,
        height: 40.0,
      ),
      title: new Text(
        item.name,
        style: listFont,
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
