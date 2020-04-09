import 'package:covid/model/statistic.model.dart';
import 'package:covid/services/http_service.dart';
import 'package:covid/style/text.components.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:covid/components/dash_statistics.component.dart';
import 'package:covid/pages/home/state_tile.component.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/appbar.component.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    HttpService().getData();
    return Scaffold(
        appBar: CustomAppBar(
          callback: () {
            setState(() {});
          },
        ).build(context),
        body: body(context));
  }

  Widget body(BuildContext context) {
    return FutureBuilder(
      future: HttpService().getData().timeout(Duration(seconds: 10)),
      builder: (BuildContext context, AsyncSnapshot<MapEntry> snapshot) {
        if (snapshot.hasData) {
          Statistic statistic = snapshot.data.key;
          String indSvg = snapshot.data.value;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                indiaImage(context, indSvg),
                SizedBox(height: 20),
                DashStatistics(statistic),
                stateWiseTileBody(statistic)
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong. I am unable to get data"),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget indiaImage(BuildContext context, String indSvg) {
    return Container(
      padding: EdgeInsets.all(30),
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(child: SvgPicture.string(indSvg, semanticsLabel: 'Acme Logo')),
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
              children: <Widget>[Title("STATE/UT"), Text("More Details")]),
          Divider(),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget stateWiseTileList(List<Statistic> states) {
    List<Widget> tiles = List();
    states.sort((a, b) => b.currentCaseData.confirmed - a.currentCaseData.confirmed);
    for (Statistic state in states) {
      if (state.currentCaseData.confirmed != 0)
        tiles.add(StateWiseTile(
          stats: state,
          enableNav: true,
        ));
    }
    return Column(
      children: tiles,
    );
  }
}
