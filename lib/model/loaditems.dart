import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:regio_food/model/item.dart';
import 'package:regio_food/strings.dart';
import 'package:regio_food/urls.dart';

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
