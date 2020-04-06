import 'package:flutter/cupertino.dart';

class MainStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          headerRow(),
          allStats(),
        ],
      ),
    );
  }

  Widget headerRow() {
    return Row(children: <Widget>[Text("INDIA CASES"), Text("12 mins ago")]);
  }

  Widget allStats() {
    return Row(
      children: <Widget>[stats(), stats(), stats(), stats()],
    );
  }

  Widget stats() {
    return Column(
      children: <Widget>[Text("[+103]"), Text("3211"), Text("Confirmed")],
    );
  }
}
