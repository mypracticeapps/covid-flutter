//import 'package:covid/maps/hex.color.dart';
//import 'package:flutter/material.dart';
//import 'package:xml/xml.dart' as xml;
//
//class SvgBuilder {
//  final builder = xml.XmlBuilder();
//  final List<MapEntry> elements = List();
//
//  SvgBuilder() {}
//
//  void createPath(xml.XmlElement element, Color fill) {
//    this.elements.add(MapEntry(element, fill));
//  }
//
//  String buildImage() {
//    this.builder.element("svg", nest: () {
//      builder.attribute("id", "india");
//      builder.attribute("xmlns", "http://www.w3.org/2000/svg");
//      builder.attribute("width", "611.86");
//      builder.attribute("height", "740");
//      builder.attribute("viewBox", "0 0 611.86 740");
//      for (MapEntry entry in this.elements) {
//        _buildElement(builder, entry.key, entry.value);
//      }
//    });
//
//    final bookshelfXml = builder.build();
//    return bookshelfXml.toString();
//  }
//
//  void _buildElement(xml.XmlBuilder myBuilder, xml.XmlElement element, Color fill) {
//    myBuilder.element(element.name.toString(), nest: () {
//      for (xml.XmlAttribute attr in element.attributes) {
//        if (attr.name.toString() != "fill") myBuilder.attribute(attr.name.toString(), attr.value);
//      }
//      String stroke = "#FF3300";
//      myBuilder.attribute("stroke", stroke);
//      myBuilder.attribute("fill", HexColor.toHex(color: fill));
//    });
//  }
//}
