import 'package:flutter/cupertino.dart';

class Statistic {
  String name;
  String code;
  RegionType regionType;
  DateTime date = DateTime.now();

  Statistic({@required this.name, @required this.code, @required this.regionType});

  CaseData currentCaseData;
  CaseData deltaCaseData;

  @override
  String toString() {
    return 'Statistic{name: $name, code: $code, regionType: $regionType, date: $date, currentCaseData: $currentCaseData, deltaCaseData: $deltaCaseData}';
  }
}

class CaseData {
  int confirmed;
  int active;
  int recovered;
  int death;

  CaseData() {
    this.confirmed = 0;
    this.active = 0;
    this.recovered = 0;
    this.death = 0;
  }
}

enum RegionType { COUNTRY, STATE, DISTRICT }

class IndiaStatistics extends Statistic {
  List<StateStatistics> states;

  IndiaStatistics({@required String name, @required String code, @required RegionType regionType})
      : super(name: name, code: code, regionType: regionType);

  StateStatistics findState({String code}) {
    for (StateStatistics state in states) {
      if (state.code == code) {
        return state;
      }
    }

    throw "Unable to find the given state. code: $code";
  }
}

class StateStatistics extends Statistic {
  List<DistrictStatistics> districts;

  StateStatistics({@required String name, @required String code, @required RegionType regionType})
      : super(name: name, code: code, regionType: regionType);
}

class DistrictStatistics extends Statistic {
  DistrictStatistics({@required String name, @required String code, @required RegionType regionType})
      : super(name: name, code: code, regionType: regionType);
}
