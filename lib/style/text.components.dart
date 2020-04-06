import 'package:flutter/material.dart' hide Title;
import 'package:google_fonts/google_fonts.dart';

class Title extends StatelessWidget {
  String text;

  Title(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        color: Color(0xff3c4858),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
