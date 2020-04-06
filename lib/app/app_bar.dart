import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      leading: Icon(Icons.menu, color: Colors.black),
      title: Text(
        "COVID 19 TRACKER IND",
        style: TextStyle(color: Color(0xe53c4858), fontSize: 18),
      ),
      backgroundColor: Color(0xfff5f5f5),
      elevation: 12,
      actions: <Widget>[
        Icon(Icons.refresh, color: Colors.black),
        SizedBox(width: 20),
      ],
    );
  }
}
