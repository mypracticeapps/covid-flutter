import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StateWiseTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: GestureDetector(
        onTap: () {
          print("on tap clicked");
        },
        child: Row(
          children: <Widget>[
            stateIcon(),
            SizedBox(width: 18),
            stateName(),
            SizedBox(width: 18),
            todayIncrement()
          ],
        ),
      ),
    );
  }

  Widget stateIcon() {
    return Container(
      color: Colors.red,
      height: 50,
      width: 50,
      child: FittedBox(
        child: SvgPicture.asset("assets/svgs/states/IN-AP.svg",
            semanticsLabel: 'Acme Logo'),
      ),
    );
  }

  Widget stateName() {
    return Expanded(
      child: Container(
//        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[currentText("564"), captionText("Utter Pradesh")],
        ),
      ),
    );
  }

  Widget todayIncrement() {
    return Column(children: <Widget>[currentText("+32"), captionText("Today")]);
  }

  Widget currentText(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget captionText(String text){
    return Text(
      text,
      style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }
}
