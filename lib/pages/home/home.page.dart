import 'package:covid/MyScreenSize.dart';
import 'package:covid/model/statistic.model.dart';
import 'package:covid/services/http_service.dart';
import 'package:covid/style/text.components.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:covid/components/dash_statistics.component.dart';
import 'package:covid/pages/home/state_tile.component.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../components/appbar.component.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IndiaStatistics indiaStatistics;
  String svgImage;
  bool error = false;

  @override
  void initState() {
    super.initState();

    HttpService().getData().timeout(Duration(seconds: 20)).then((me) {
      setState(() {
        indiaStatistics = me.key;
        svgImage = me.value;
        print("complete data");
      });
    }, onError: (error) {
      this.error = true;
    });
  }

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          callback: () {
            setState(() {});
          },
        ).build(context),
        body: HomePageBody(
          indiaStatistics: indiaStatistics,
          svgImage: svgImage,
          error: error,
        ));
  }
}

class HomePageBody extends StatelessWidget {
  IndiaStatistics indiaStatistics;
  String svgImage;
  bool error;

  HomePageBody({this.indiaStatistics, this.svgImage, this.error});

  @override
  Widget build(BuildContext context) {
    MyScreenSize.init(context);
    return myBody();
  }

  Widget myBody() {
    if (error == true) {
      return errorScreen();
    } else if (indiaStatistics == null) {
      return loading();
    } else {
      return loaded();
    }
  }

  Widget loading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget errorScreen() {
    return Center(
      child: Text("Something went wrong. I am unable to get data"),
    );
  }

  Widget loaded() {
    return SlidingUpPanel(
      minHeight: MyScreenSize.height * 0.3,
      maxHeight: MyScreenSize.height,
      body: myIndiaImage(svgImage),
      panelBuilder: (ScrollController sc) {
        return SingleChildScrollView(
          controller: sc,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              DashStatistics(indiaStatistics),
              stateWiseTileBody(indiaStatistics)
            ],
          ),
        );
      },
    );
  }

  Widget myIndiaImage(String indSvg) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(15, 25,15,0),
          height: MyScreenSize.height * 0.6,
          width: double.infinity,
          child: SvgPicture.string(indSvg, semanticsLabel: 'INDIA SVG'),
        )
      ],
    );
  }

  Widget stateWiseTileBody(IndiaStatistics statistic) {
    return Column(
      children: <Widget>[
        stateWiseHeaderRow(),
        stateWiseTileList(statistic.states),
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

  Widget stateWiseTileList(List<StateStatistics> states) {
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
