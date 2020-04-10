import 'package:covid/maps/hex.color.dart';
import 'package:flutter/material.dart';

class ColorMapping {
  int total;
  List<ColorLookupEntry> mappings = List();

  ColorMapping({this.total}) {
    int common = total ~/ 5;

    mappings.add(ColorLookupEntry(0, 0, Colors.white));

    String color1 = "#ffc2b3";
    String color2 = "#ff9980";
    String color3 = "#ff704d";
    String color4 = "#ff471a";
    String color5 = "#e62e00";
    String color6 = "#b32400";

    int start = 1;
    int end = common;
    ColorLookupEntry entry = ColorLookupEntry(start, end, HexColor.fromHex(color1));
    mappings.add(entry);

    start = 1 + end;
    end = end + common;
    entry = ColorLookupEntry(start, end, HexColor.fromHex(color2));
    mappings.add(entry);

    start = 1 + end;
    end = end + common;
    entry = ColorLookupEntry(start, end, HexColor.fromHex(color3));
    mappings.add(entry);

    start = 1 + end;
    end = end + common;
    entry = ColorLookupEntry(start, end, HexColor.fromHex(color4));
    mappings.add(entry);

    start = 1 + end;
    end = end + common;
    entry = ColorLookupEntry(start, end, HexColor.fromHex(color5));
    mappings.add(entry);

    start = 1 + end;
    end = 10000000000;
    entry = ColorLookupEntry(start, end, HexColor.fromHex(color6));
    mappings.add(entry);
  }

  Color colorFor(int number) {
    for (ColorLookupEntry entry in mappings) {
      if (entry.isAcceptable(number)) {
        return entry.color;
      }
    }
    return Colors.grey;
  }

  String colorStringFor(int number) {
    return HexColor.toHex(color: colorFor(number));
  }

  ColorLookupEntry mappingForPosition(int number) {
    return mappings.elementAt(number);
  }
}

class ColorLookupEntry {
  int start;
  int end;
  Color color;

  ColorLookupEntry(this.start, this.end, this.color);

  bool isAcceptable(int num) {
    return num >= start && num <= end;
  }
}
