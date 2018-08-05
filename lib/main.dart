import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Strings.dart';
import 'Styles.dart';
import 'plist.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: mainTitle,
        theme: new ThemeData(
          primaryColorBrightness: Brightness.light,
        ),
        home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double aspectRatio;
    double paddingBottom;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      aspectRatio = 3.3;
      paddingBottom = 40.0;
    } else {
      aspectRatio = 5.5;
      paddingBottom = 24.0;
    }

    Widget titleSection = Padding(
      padding: EdgeInsets.only(bottom: paddingBottom, left: 16.0, right: 16.0),
      child: Text(
        mainDescription,
        style: subtitleStyle,
      ),
    );

    AlignmentGeometry align;
    Widget provinceSection = new Expanded(
        child: new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
      ),
      itemCount: provinceList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) {
          align = FractionalOffset.centerLeft;
        } else {
          align = FractionalOffset.centerRight;
        }
        return new Align(
          alignment: align,
          child: new FlatButton(
            padding: const EdgeInsets.all(8.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PList(province: provinceList[index])),
              );
            },
            child: new Text(
              provinceList[index],
              style: rowStyle,
            ),
          ),
        );
      },
    ));

    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            mainTitle,
            style: titleStyle,
          ),
        ),
        body: Column(
          children: <Widget>[titleSection, provinceSection],
        ));
  }
}
