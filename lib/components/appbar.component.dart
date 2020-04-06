import 'package:flutter/material.dart' hide Title;
import 'package:google_fonts/google_fonts.dart';
import 'package:covid/style/text.components.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      leading: Icon(Icons.menu, color: Colors.black),
      title: Title("COVID 19 TRACKER IND"),
      backgroundColor: Color(0xfff5f5f5),
      elevation: 12,
      actions: <Widget>[
        Icon(Icons.refresh, color: Colors.black),
        SizedBox(width: 20),
      ],
    );
  }
}
