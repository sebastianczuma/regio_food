import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Item.dart';
import 'Strings.dart';
import 'Styles.dart';
import 'Urls.dart';

String whatsNow;

Future<myCategory> fetchItems(http.Client client, String province) async {
  final response = await client.get(BASE_URL + province + '.json');

  return compute(parseItems, response.body);
}

myCategory parseItems(String responseBody) {
  final parsed = json.decode(responseBody);

  List<Item> items = new List<Item>();

  if (parsed['produkty_mleczne'] != null) {
    items.add(new Item('produkty mleczne', ''));
    for (var name in parsed['produkty_mleczne']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['produkty_miesne'] != null) {
    items.add(new Item('produkty mięsne', ''));
    for (var name in parsed['produkty_miesne']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['produkty_rybolowstwa'] != null) {
    items.add(new Item('produkty rybołówstwa', ''));
    for (var name in parsed['produkty_rybolowstwa']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['warzywa_i_owoce'] != null) {
    items.add(new Item('warzywa i owoce', ''));
    for (var name in parsed['warzywa_i_owoce']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['wyroby_piekarnicze_i_cukiernicze'] != null) {
    items.add(new Item('wyroby piekarnicze i cukiernicze', ''));
    for (var name in parsed['wyroby_piekarnicze_i_cukiernicze']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['oleje_i_tluszcze'] != null) {
    items.add(new Item('oleje i tłuszcze', ''));
    for (var name in parsed['oleje_i_tluszcze']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['miody'] != null) {
    items.add(new Item('miody', ''));
    for (var name in parsed['miody']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['gotowe_dania_i_potrawy'] != null) {
    items.add(new Item('gotowe dania i potrawy', ''));
    for (var name in parsed['gotowe_dania_i_potrawy']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['napoje'] != null) {
    items.add(new Item('napoje', ''));
    for (var name in parsed['napoje']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  if (parsed['inne_produkty'] != null) {
    items.add(new Item('inne produkty', ''));
    for (var name in parsed['inne_produkty']) {
      items.add(new Item(name['name'], name['url']));
    }
  }

  return new myCategory(items);
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
      body: FutureBuilder<myCategory>(
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
  final myCategory items;

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

          if (items.products[index].name == 'produkty mleczne' ||
              items.products[index].name == 'produkty mięsne' ||
              items.products[index].name == 'produkty rybołówstwa' ||
              items.products[index].name == 'warzywa i owoce' ||
              items.products[index].name ==
                  'wyroby piekarnicze i cukiernicze' ||
              items.products[index].name == 'oleje i tłuszcze' ||
              items.products[index].name == 'miody' ||
              items.products[index].name == 'gotowe dania i potrawy' ||
              items.products[index].name == 'napoje' ||
              items.products[index].name == 'inne produkty') {
            whatsNow = removePolishChars(items.products[index].name)
                .replaceAll(' ', '_');
            return _buildRowTitle(items.products[index].name);
          }

          return _buildRow(items.products[index], whatsNow);
        });
  }

  Widget _buildRow(Item item, String whatsNow) {
    return new ListTile(
      leading: Image.asset(
        'assets/images/' + whatsNow + '.png',
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
