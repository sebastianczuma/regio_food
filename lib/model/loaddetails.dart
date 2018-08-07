import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:regio_food/strings.dart';
import 'package:regio_food/urls.dart';

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
