import 'package:covid/model/statistic.model.dart';
import 'package:covid/services/http_service.dart';
import 'package:covid/style/text.components.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:covid/components/dash_statistics.component.dart';
import 'package:covid/pages/home/state_tile.component.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/appbar.component.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpService().getData();
    return Scaffold(appBar: CustomAppBar().build(context), body: body(context));
  }

  Widget body(BuildContext context) {
    return FutureBuilder(
      future: HttpService().getData(),
      builder: (BuildContext context, AsyncSnapshot<Statistic> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
//          indiaImage(context),
                SizedBox(height: 20),
                DashStatistics(),
                stateWiseTileBody()
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
        child: FittedBox(child: SvgPicture.asset(asset, semanticsLabel: 'Acme Logo')),
      ),
    );
  }

  Widget stateWiseTileBody() {
    return Column(
      children: <Widget>[
        stateWiseHeaderRow(),
        stateWiseTileList(),
      ],
    );
  }

  Widget stateWiseHeaderRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Title("STATE/UT"), Text("More Details")]),
          Divider(),
          SizedBox(
            height: 5,
          )
        ],
      ),
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
