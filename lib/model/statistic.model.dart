import 'package:covid/model/case_data.dart';
import 'package:flutter/cupertino.dart';

class Statistic {
  String name;
  String code;
  RegionType regionType;
  DateTime date = DateTime.now();

  Statistic(
      {@required this.name, @required this.code, @required this.regionType});

  CaseData currentCaseData;
  CaseData deltaCaseData;

  List<Statistic> subStatistics;

  @override
  String toString() {
    return 'Statistic{name: $name, code: $code, regionType: $regionType, date: $date, currentCaseData: $currentCaseData, deltaCaseData: $deltaCaseData, subStatistics: $subStatistics}';
  }
}

enum RegionType { COUNTRY, STATE, DISTRICT }
