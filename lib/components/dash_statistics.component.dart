import 'package:covid/model/statistic.model.dart';
import 'package:covid/style/text.components.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:google_fonts/google_fonts.dart';
import 'package:random_color/random_color.dart';
import 'package:timeago/timeago.dart' as timeago;

RandomColor _randomColor = RandomColor();

class DashStatistics extends StatelessWidget {
  Statistic statistic;

  DashStatistics(this.statistic);

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
          Title("${statistic.name.toUpperCase()} CASES"),
//          Text("${timeago.format(statistic.date)}"),
        ]);
  }

  Widget allStats() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SingleBoxStatistic(statistic, "CONFIRMED"),
        SingleBoxStatistic(statistic, "ACTIVE"),
        SingleBoxStatistic(statistic, "RECOVERED"),
        SingleBoxStatistic(statistic, "DEATH"),
//        stats("Active", Colors.blue),
//        stats("Recovered", Colors.green[700]),
//        stats("Death", Colors.red),
      ],
    );
  }
}

class SingleBoxStatistic extends StatelessWidget {
  Statistic statistic;
  String type;

  SingleBoxStatistic(this.statistic, this.type);

  @override
  Widget build(BuildContext context) {
    if (type == "CONFIRMED") {
      return _assemble(
          statistic.currentCaseData.confirmed, statistic.deltaCaseData.confirmed, "Confirmed", Colors.yellow[800]);
    } else if (type == "ACTIVE") {
      return _assemble(
          statistic.currentCaseData.active, statistic.deltaCaseData.active, "Active", Colors.blue);
    } else if (type == "RECOVERED") {
      return _assemble(
          statistic.currentCaseData.recovered, statistic.deltaCaseData.recovered, "Recovered", Colors.green[700]);
    } else if (type == "DEATH") {
      return _assemble(statistic.currentCaseData.death, statistic.deltaCaseData.death, "Death", Colors.red);
    }
    return null;
  }

  Widget _assemble(int current, int delta, String captionStr, Color color) {
    return Column(
      children: <Widget>[
        deltaText(delta, color),
        currentCount("$current", color),
        caption(captionStr),
      ],
    );
  }

  Widget deltaText(int num, Color color) {
//    Opacity(
//      opacity: _visible ? 1.0 : 0.0,
//      child: const Text('Now you see me, now you don\'t!'),
//    )


    return Opacity(
      opacity: num!=0 ? 1.0 : 0.0,
      child: Text(
        "[+${num.toString()}]",
        style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Widget currentCount(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget caption(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.normal),
    );
  }
}
