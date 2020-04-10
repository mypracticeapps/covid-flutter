import 'package:covid/model/statistic.model.dart';
import 'package:covid/pages/home/state.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StateWiseTile extends StatelessWidget {
  Statistic stats;
  bool enableNav;
  bool enableToday;

  StateWiseTile({this.stats, this.enableNav: true, this.enableToday = true});

  @override
  Widget build(BuildContext context) {
    if (this.enableNav) {
      return clickableTile(context);
    } else {
      return nonClickableTile(context);
    }
  }

  @override
  Widget clickableTile(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            print("on tap clicked");
            Navigator.push(context, MaterialPageRoute(builder: (context) => TextPage(this.stats)));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 7),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
//                stateIcon(),
//                SizedBox(width: 18),
                    stateName(),
                    SizedBox(width: 18),
                    todayIncrement(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Divider(),
        ),
      ],
    );
  }

  @override
  Widget nonClickableTile(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 7),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
//                stateIcon(),
//                SizedBox(width: 18),
                  stateName(),
                  SizedBox(width: 18),
                  todayIncrement(),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Divider(),
        ),
      ],
    );
  }

  Widget stateIcon() {
    return Container(
      color: Colors.red,
      height: 50,
      width: 50,
      child: FittedBox(
        child: SvgPicture.asset("assets/svgs/states/IN-AP.svg", semanticsLabel: 'Acme Logo'),
      ),
    );
  }

  Widget stateName() {
    return Expanded(
      child: Container(
//        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[currentText("${stats.currentCaseData.confirmed}"), captionText(stats.name)],
        ),
      ),
    );
  }

  Widget todayIncrement() {
    if (this.enableToday) {
      return Column(children: <Widget>[currentText("${stats.deltaCaseData.confirmed}"), captionText("Today")]);
    } else {
      return SizedBox(
        width: 1,
      );
    }
  }

  Widget currentText(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(175, 0, 0, 0),
      ),
    );
  }

  Widget captionText(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.normal),
    );
  }
}
