import 'package:covid/model/common.model.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart';

class MySvgParser {
  Map<String, xml.XmlElement> states = Map();
  Map<String, Pair<xml.XmlElement, xml.XmlElement>> infoTailsMap = Map();

  MySvgParser();

  xml.XmlElement getState(String code) {
    if (states.containsKey(code) == false) {
      throw "Unable to find state svg xml element for state: $code";
    } else {
      return states[code];
    }
  }

  Pair<xml.XmlElement, xml.XmlElement> getInfoBox(String position) {
    if (infoTailsMap.containsKey(position) == false) {
      throw "Unable to find info box svg xml element for position: $position";
    } else {
      return infoTailsMap[position];
    }
  }

  void parse() async {
    String imageData = await rootBundle.loadString('assets/svgs/india3.svg');
    final document = xml.parse(imageData);

    _processTags("path", document);
    _processTags("text", document);
    _processTags("rect", document);
  }

  void _processTags(String name, xml.XmlDocument document) {
    Iterable<xml.XmlElement> list = document.findAllElements(name);
    for (xml.XmlElement element in list) {
      if (_isState(element)) {
        String code = _getValueForId(element);
        states.putIfAbsent(code, () => element);
      } else if (_isInfoTile(element)) {
        String position = _getInfoTailPosition(element);
        Pair<xml.XmlElement, xml.XmlElement> infoTail = infoTailsMap[position];
        if (infoTail == null) {
          infoTail = Pair();
          infoTailsMap[position] = infoTail;
        }

        if (_isInfoTailColor(element)) {
          infoTail.key = element;
        } else if (_isInfoTailText(element)) {
          infoTail.value = element;
        }
      }
    }
  }

  bool _isState(xml.XmlElement element) {
    String value = _getValueForId(element);
    bool isColorBox = value.startsWith("BOX");
    return _getValueForId(element).startsWith("IN-");
  }

  bool _isInfoTile(xml.XmlElement element) {
    String value = _getValueForId(element);
    bool isColorBox = value.startsWith("BOX");
    return isColorBox;
  }

  bool _isInfoTailText(xml.XmlElement element) {
    String value = _getValueForId(element);
    bool isText = value.startsWith("BOXTEXT");
    return isText;
  }

  bool _isInfoTailColor(xml.XmlElement element) {
    String value = _getValueForId(element);
    bool isColor = value.startsWith("BOXCOLOR");
    return isColor;
  }

  String _getInfoTailPosition(xml.XmlElement element) {
    String value = _getValueForId(element);
    String position = value.substring(value.length - 1);
    return position;
  }

  String _getValueForId(xml.XmlElement element) {
    for (xml.XmlAttribute attr in element.attributes) {
      if (attr.name.toString().toLowerCase() == "id") {
        return attr.value;
      }
    }
    return "";
  }
}
