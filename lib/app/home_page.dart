import 'package:covid/app/app_bar.dart';
import 'package:covid/app/main_stats.dart';
import 'package:covid/app/state_stat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar().build(context),
      body: Column(
        children: <Widget>[
          india(),
          MainStart(),
          StateStats(),
        ],
      ),
    );
  }

  Widget india() {
    return FittedBox(
      child: SvgPicture.asset("assets/svgs/placeholder.svg",
          semanticsLabel: 'Acme Logo'),
    );
  }
}
