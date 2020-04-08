import 'package:flutter/material.dart' hide Title;
import 'package:covid/style/text.components.dart';

class CustomAppBar extends StatelessWidget {
  bool enableBack;
  bool enableRefresh;
  Function callback;

  CustomAppBar({this.enableBack: false, this.enableRefresh: true, this.callback}) {}

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      leading: backBtnOrLogo(context),
      title: Title("COVID 19 INDIA TRACKER"),
      backgroundColor: Color(0xfff5f5f5),
      elevation: 12,
      actions: actions(),
    );
  }

  List<Widget> actions() {
    if (this.enableRefresh) {
      return <Widget>[
        InkWell(
          onTap: () {
            if (callback != null && callback is Function) {
              callback();
            }
          },
          child: Container(width: 50, child: Icon(Icons.refresh, color: Colors.black)),
        ),
//        SizedBox(width: 20),
      ];
    }
    return [];
  }

  Widget backBtnOrLogo(BuildContext context) {
    if (this.enableBack) {
      return InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black));
    } else {
      return Icon(Icons.menu, color: Colors.black);
    }
  }
}
