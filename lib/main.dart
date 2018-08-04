import 'package:flutter/material.dart';
import 'plist.dart';
import 'package:flutter/services.dart';

TextStyle rowStyle = new TextStyle(
    fontFamily: 'WorkSans',
    color: Color(0xFFD16A68),
    fontWeight: FontWeight.bold,
    fontSize: 16.0);

TextStyle titleStyle = new TextStyle(
    color: Colors.black,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 22.0);

TextStyle subtitleStyle = new TextStyle(
    color: Colors.black,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.normal,
    fontSize: 18.0);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Produkty regionalne',
        theme: new ThemeData(
          primaryColorBrightness: Brightness.light,
        ),
        home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget titleSection = Padding(
      padding: EdgeInsets.only(bottom: 56.0, left: 16.0, right: 16.0),
      child: Text(
        'Wybierz województwo aby wyświetlić produkty regionalne dla tego obszaru.',
        style: subtitleStyle,
      ),
    );

    Row buildRow(String province1, String province2) {
      return Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 12.0),
                child: new Align(
                  alignment: FractionalOffset.centerRight,
                  child: new FlatButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                new PList(province: province1)),
                      );
                    },
                    child: new Text(
                      province1,
                      style: rowStyle,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 12.0),
                child: new Align(
                  alignment: FractionalOffset.centerLeft,
                  child: new FlatButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PList(province: province2)),
                      );
                    },
                    child: new Text(
                      province2,
                      style: rowStyle,
                    ),
                  ),
                ),
              ),
            ),
          ]);
    }

    Widget columnSection = Container(
      child: Column(
        children: [
          buildRow('dolnośląskie', 'kujawsko-pomorskie'),
          buildRow('lubelskie', 'łódzkie'),
          buildRow('lubuskie', 'małopolskie'),
          buildRow('mazowieckie', 'opolskie'),
          buildRow('podkarpackie', 'podlaskie'),
          buildRow('pomorskie', 'śląskie'),
          buildRow('świętokrzyskie', 'warmińsko-mazurskie'),
          buildRow('wielkopolskie', 'zachodniopomorskie'),
        ],
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Produkty regionalne',
          style: titleStyle,
        ),
      ),
      body: Column(
        children: [
          titleSection,
          columnSection,
        ],
      ),
    );
  }
}
