import 'package:covid/components/appbar.component.dart';
import 'package:covid/components/dash_statistics.component.dart';
import 'package:covid/model/statistic.model.dart';
import 'package:covid/pages/home/state_tile.component.dart';
import 'package:covid/style/text.components.dart';
import 'package:flutter/material.dart' hide Title;

class TextPage extends StatelessWidget {
  Statistic statistic;

  TextPage(this.statistic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(enableBack: true, enableRefresh: false).build(context), body: body(context));
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[SizedBox(height: 20), DashStatistics(this.statistic), stateWiseTileBody(this.statistic)],
      ),
    );
  }

  Widget stateWiseTileBody(Statistic statistic) {
    return Column(
      children: <Widget>[
        stateWiseHeaderRow(),
        stateWiseTileList(statistic.subStatistics),
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
              children: <Widget>[Title("DISTRICT"), Text("More Details")]),
          Divider(),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget stateWiseTileList(List<Statistic> dists) {
    List<Widget> tiles = List();
    dists.sort((a, b) => b.currentCaseData.confirmed - a.currentCaseData.confirmed);

    for (Statistic dist in dists) {
      if (dist.currentCaseData.confirmed != 0)
        tiles.add(StateWiseTile(
          stats: dist,
          enableNav: false,
        ));
    }
    return Column(
      children: tiles,
    );
  }
}
