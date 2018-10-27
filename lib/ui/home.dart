import 'package:flutter/material.dart';
import 'package:regio_food/strings.dart';
import 'package:regio_food/styles.dart';
import 'package:regio_food/ui/plist.dart';

class Home extends StatelessWidget {
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
    Widget provinceSection = Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        return Align(
          alignment: align,
          child: FlatButton(
            padding: const EdgeInsets.all(8.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PList(province: provinceList[index])),
              );
            },
            child: Text(
              provinceList[index],
              style: rowStyle,
            ),
          ),
        );
      },
    ));

    return Scaffold(
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
