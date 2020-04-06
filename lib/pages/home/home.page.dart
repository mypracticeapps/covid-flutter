import 'package:covid/style/text.components.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:covid/components/dash_statistics.component.dart';
import 'package:covid/pages/home/state_tile.component.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/appbar.component.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar().build(context), body: body(context));
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          indiaImage(context),
          DashStatistics(),
          stateWiseTileBody()
        ],
      ),
    );
  }

  Widget indiaImage(BuildContext context) {
    String asset = "assets/svgs/placeholder.svg";
    return Container(
      padding: EdgeInsets.all(30),
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
            child: SvgPicture.asset(asset, semanticsLabel: 'Acme Logo')),
      ),
    );
  }

  Widget stateWiseTileBody() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        children: <Widget>[stateWiseHeaderRow(), stateWiseTileList()],
      ),
    );
  }

  Widget stateWiseHeaderRow() {
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Title("State/UT"), Text("More Details")]),
        Divider()
      ],
    );
  }

  Widget stateWiseTileList() {
    List<Widget> tiles = List();
    for (int ii = 0; ii < 20; ii++) {
      tiles.add(StateWiseTile());
    }
    return Column(
      children: tiles,
    );
  }
}
