import 'package:covid/services/svg.util.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart';

class MapService {
  Future<String> indiaMap() async {
    String test = await rootBundle.loadString('assets/svgs/india3.svg');

    final document = xml.parse(test);
    SvgBuilder builder = SvgBuilder();
    _processTags("path", document, builder);
    _processTags("text", document, builder);
    _processTags("rect", document, builder);
    String image = builder.buildImage();
    print(image);
    return image;
  }

  void _processTags(String name, xml.XmlDocument document, SvgBuilder builder) {
    Iterable<xml.XmlElement> list = document.findAllElements(name);
    for (xml.XmlElement element in list) {
      if (_isState(element)) {
        builder.createPath(element, Colors.red);
      } else if (_isColorBox(element)) {
        builder.createPath(element, Colors.red);
      }
    }
  }

  bool _isState(xml.XmlElement element) {
    String value = _getValueForId(element, "id");
    bool isColorBox = value.startsWith("BOX");
//    print("$value is State: $isColorBox");
    return _getValueForId(element, "id").startsWith("IN-");
  }

  bool _isColorBox(xml.XmlElement element) {
    String value = _getValueForId(element, "id");
    bool isColorBox = value.startsWith("BOX");
    return isColorBox;
  }

  String _getValueForId(xml.XmlElement element, String id) {
    for (xml.XmlAttribute attr in element.attributes) {
      if (attr.name.toString().toLowerCase() == "id") {
        return attr.value;
      }
    }
    return "";
  }
}
