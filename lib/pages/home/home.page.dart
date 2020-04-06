import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          children: <Widget>[
            indiaImage()
          ],
        ));
  }

  Widget appBar() {
    return AppBar(title: Text("COVID-19 Tracker IND"));
  }

  Widget indiaImage() {
    return null;
  }
}
