import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        headerRow(),
      ],
    );
  }

  Widget headerRow() {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[Text("State/UT"), Text("More Details")]),
        Divider()
      ],
    );
  }

//  Widget stateRow(){
//    return Row(
//      children: <Widget>[
//
//      ],
//    );
//  }
}
