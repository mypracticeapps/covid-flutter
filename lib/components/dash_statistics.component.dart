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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        stats("Confirmed", Colors.yellow[800]),
        stats("Active", Colors.blue),
        stats("Recovered", Colors.green[700]),
        stats("Death", Colors.red),
      ],
    );
  }

  Widget stats(String captionStr, Color color) {
    return Column(
      children: <Widget>[
        deltaText("103", color),
        currentCount("3211", color),
        caption(captionStr),
      ],
    );
  }

  Widget deltaText(String text, Color color) {
    return Text(
      "[+$text]",
      style: GoogleFonts.openSans(
          fontSize: 12, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget currentCount(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          fontSize: 20, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget caption(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.normal),
    );
  }
}
