import 'package:covid/maps/MySvgParser.dart';
import 'package:covid/maps/color.mapping.dart';
import 'package:covid/maps/hex.color.dart';
import 'package:covid/model/common.model.dart';
import 'package:covid/model/statistic.model.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

class MySvgBuilder {
  IndiaStatistics india;
  final builder = xml.XmlBuilder();
  ColorMapping colorMapping;

  MySvgBuilder({this.india}) {
    colorMapping = ColorMapping(total: this.india.states[0].currentCaseData.confirmed);
  }

  Future<String> build() async {
    MySvgParser svgParser = MySvgParser();
    await svgParser.parse();

    this.builder.element("svg", nest: () {
      builder.attribute("id", "india");
      builder.attribute("xmlns", "http://www.w3.org/2000/svg");
      builder.attribute("width", "611.86");
      builder.attribute("height", "740");
      builder.attribute("viewBox", "0 0 611.86 740");
//      _buildInfoTails(svgParser);
      _buildStates(svgParser);
    });

    final bookshelfXml = builder.build();
    return bookshelfXml.toString();
  }

  void _buildInfoTails(MySvgParser svgParser) {
    for (int ii = 1; ii <= 6; ii++) {
      Pair<xml.XmlElement, xml.XmlElement> infoTail = svgParser.getInfoBox("$ii");
      ColorLookupEntry colorLookupEntry = colorMapping.mappingForPosition(ii);
      String caption = "${colorLookupEntry.start} - ${colorLookupEntry.end}";
      String fillColor = HexColor.toHex(color: colorLookupEntry.color);
      _buildElement(element: infoTail.key, fillColor: fillColor);
      _buildElement(element: infoTail.value, text: caption);
    }
  }

  void _buildStates(MySvgParser svgParser) {
    for (StateStatistics statistics in india.states) {
      xml.XmlElement element = svgParser.getState(statistics.code);
      String fillColor = colorMapping.colorStringFor(statistics.currentCaseData.confirmed);
      String stroke = HexColor.toHex(color: Colors.red);
      _buildElement(element: element, fillColor: fillColor, strokeColor: stroke);
    }
  }

  void _buildElement({xml.XmlElement element, String fillColor, String strokeColor, String text}) {
    builder.element(element.name.toString(), nest: () {
      for (xml.XmlAttribute attr in element.attributes) {
        if (attr.name.toString() == "fill") {
          continue;
        } else if (attr.name.toString() == "stroke") {
          continue;
        } else {
          builder.attribute(attr.name.toString(), attr.value);
        }
      }
      if (fillColor != null && fillColor != "") {
        builder.attribute("fill", fillColor);
      }
      if (strokeColor != null && strokeColor != "") {
        builder.attribute("stroke", strokeColor);
      }
      if (text != null && text != "") {
        builder.text(text);
      }
    });
  }
}
