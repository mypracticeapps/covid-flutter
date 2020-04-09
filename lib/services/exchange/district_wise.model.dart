import 'dart:convert';

import 'package:covid/model/statistic.model.dart';

List<DistrictWiseRes> districtWiseResFromJson(String str) =>
    List<DistrictWiseRes>.from(json.decode(str).map((x) => DistrictWiseRes.fromJson(x)));

String districtWiseResToJson(List<DistrictWiseRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

void fillStateAndDistrictData(IndiaStatistics india, List<DistrictWiseRes> distList) {
  distList.forEach((dt) => dt.fillStatistic(india.states));
}

class DistrictWiseRes {
  String state;
  List<DistrictDatum> districtData;

  DistrictWiseRes({
    this.state,
    this.districtData,
  });

  void fillStatistic(List<StateStatistics> states) {
    StateStatistics state = states.firstWhere((st) => st.name == this.state, orElse: () {
      print("Not found");
      return null;
    });
    if (state == null) return;
    List<DistrictStatistics> stats = this.districtData.map((dt) => dt.toStatistic()).toList();
    state.districts = stats;
  }

  factory DistrictWiseRes.fromJson(Map<String, dynamic> json) => DistrictWiseRes(
        state: json["state"],
        districtData: List<DistrictDatum>.from(json["districtData"].map((x) => DistrictDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "districtData": List<dynamic>.from(districtData.map((x) => x.toJson())),
      };
}

class DistrictDatum {
  String district;
  int confirmed;
  String lastupdatedtime;
  Delta delta;

  DistrictDatum({
    this.district,
    this.confirmed,
    this.lastupdatedtime,
    this.delta,
  });

  DistrictStatistics toStatistic() {
    DistrictStatistics statistic = DistrictStatistics(name: district, code: "NA", regionType: RegionType.DISTRICT);
    CaseData current = CaseData();
    current.confirmed = this.confirmed;
    statistic.currentCaseData = current;
    CaseData delta = CaseData();
    delta.confirmed = this.delta.confirmed;
    statistic.deltaCaseData = delta;
    return statistic;
  }

  factory DistrictDatum.fromJson(Map<String, dynamic> json) => DistrictDatum(
        district: json["district"],
        confirmed: json["confirmed"],
        lastupdatedtime: json["lastupdatedtime"],
        delta: Delta.fromJson(json["delta"]),
      );

  Map<String, dynamic> toJson() => {
        "district": district,
        "confirmed": confirmed,
        "lastupdatedtime": lastupdatedtime,
        "delta": delta.toJson(),
      };
}

class Delta {
  int confirmed;

  Delta({
    this.confirmed,
  });

  factory Delta.fromJson(Map<String, dynamic> json) => Delta(
        confirmed: json["confirmed"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed,
      };
}
