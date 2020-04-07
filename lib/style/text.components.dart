import 'package:flutter/material.dart' hide Title;
import 'package:google_fonts/google_fonts.dart';

class Title extends StatelessWidget {
  String text;

  Title(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        color: Color(0xdd222222),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
