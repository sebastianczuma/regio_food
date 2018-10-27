import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:regio_food/model/item.dart';
import 'package:regio_food/model/loaditems.dart';
import 'package:regio_food/strings.dart';
import 'package:regio_food/styles.dart';
import 'package:regio_food/ui/pdetails.dart';

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
              ? ItemsList(items: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ItemsList extends StatelessWidget {
  final List<Item> items;

  ItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length * 2,
        itemBuilder: (BuildContext _context, int i) {
          final int index = i ~/ 2;

          if (i.isOdd) {
            return Divider();
          }

          for (var name in categoryListSmall) {
            if (items[index].name == name) {
              return _buildRowTitle(items[index].name);
            }
          }

          return _buildRow(items[index], context);
        });
  }

  Widget _buildRow(Item item, BuildContext context) {
    return ListTile(
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
      title: Text(
        item.name,
        style: listFont,
      ),
    );
  }

  Widget _buildRowTitle(String pair) {
    return ListTile(
      title: Text(
        pair,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
