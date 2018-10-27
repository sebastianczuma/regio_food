import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:regio_food/model/item.dart';
import 'package:regio_food/strings.dart';
import 'package:regio_food/urls.dart';

Future<List<Item>> fetchItems(http.Client client, String province) async {
  final response = await client.get(BASE_URL + province + '.json');

  return parseItems(response.body);
}

List<Item> parseItems(String responseBody) {
  final parsed = json.decode(responseBody);

  List<Item> items = List<Item>();

  for (int i = 0; i < categoryListForDownload.length; i++) {
    if (parsed[categoryListForDownload[i]] != null) {
      items.add(Item(categoryListSmall[i], '', ''));
      for (var item in parsed[categoryListForDownload[i]]) {
        items.add(Item(item['name'], item['url'], item['category']));
      }
    }
  }

  return items;
}
