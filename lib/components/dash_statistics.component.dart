import 'package:covid/style/text.components.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:google_fonts/google_fonts.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class DashStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        children: <Widget>[
          headerRow(),
          SizedBox(height: 18),
          allStats(),
          SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget headerRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Title("INDIA CASES"),
          Text("12 mins ago"),
        ]);
  }

  Widget allStats() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[stats(), stats(), stats(), stats()],
    );
  }

  Widget stats() {
    return Column(
      children: <Widget>[
        deltaText("103"),
        currentCount("3211"),
        caption("Confirmed"),
      ],
    );
  }

  Widget deltaText(String text) {
    return Text(
      "[+$text]",
      style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget currentCount(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget caption(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.normal),
    );
  }
}
