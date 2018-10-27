import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:regio_food/model/details.dart';
import 'package:regio_food/strings.dart';
import 'package:regio_food/urls.dart';

Future<List<String>> fetchDetail(http.Client client, String province) async {
  final response = await client.get(BASE_URL_DETAILS + province + '.json');

  return decodeJsonForDetail(response.body);
}

List<String> decodeJsonForDetail(String responseBody) {
  Details foodDetails =
  Details.fromJson(json.decode(responseBody) as Map<String, dynamic>);

  List<String> parsedDetails = [];
  List<String> details = [];

  parsedDetails.add(foodDetails.name);
  parsedDetails.add(foodDetails.look);
  parsedDetails.add(foodDetails.shape);
  parsedDetails.add(foodDetails.size);
  parsedDetails.add(foodDetails.color);
  parsedDetails.add(foodDetails.consistency);
  parsedDetails.add(foodDetails.taste);
  parsedDetails.add(foodDetails.other);
  parsedDetails.add(foodDetails.tradition);

  for (int i = 0; i < detailTitles.length; i++) {
    if (i != 0) {
      parsedDetails.add(detailTitles[i]);
    }
    if (parsedDetails[i] != null && parsedDetails[i].isNotEmpty) {
      details.add(parsedDetails[i]);
    } else {
      details.add('-');
    }
  }

  details.add(foodDetails.category);

  return details;
}
