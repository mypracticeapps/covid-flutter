import 'dart:convert';

import 'package:covid/model/statistic.model.dart';

NationAndStateWideRes nationAndStateWideResFromJson(String str) => NationAndStateWideRes.fromJson(json.decode(str));

String nationAndStateWideResToJson(NationAndStateWideRes data) => json.encode(data.toJson());

class NationAndStateWideRes {
  List<CasesTimeSery> casesTimeSeries;
  List<Statewise> statewise;
  List<Tested> tested;

  NationAndStateWideRes({
    this.casesTimeSeries,
    this.statewise,
    this.tested,
  });

  IndiaStatistics toStatistics() {
    List<StateStatistics> stats = this.statewise.map((st) => st.toStatistics()).toList();
    Statistic indSt = stats.firstWhere((st) => st.code == "TT");
    stats.remove(indSt);

    IndiaStatistics india = IndiaStatistics(name: "India", code: "IN", regionType: RegionType.COUNTRY);
    india.currentCaseData = indSt.currentCaseData;
    india.deltaCaseData = indSt.deltaCaseData;
    india.states = stats;
    return india;
  }

  factory NationAndStateWideRes.fromJson(Map<String, dynamic> json) => NationAndStateWideRes(
        casesTimeSeries: List<CasesTimeSery>.from(json["cases_time_series"].map((x) => CasesTimeSery.fromJson(x))),
        statewise: List<Statewise>.from(json["statewise"].map((x) => Statewise.fromJson(x))),
        tested: List<Tested>.from(json["tested"].map((x) => Tested.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cases_time_series": List<dynamic>.from(casesTimeSeries.map((x) => x.toJson())),
        "statewise": List<dynamic>.from(statewise.map((x) => x.toJson())),
        "tested": List<dynamic>.from(tested.map((x) => x.toJson())),
      };
}

class CasesTimeSery {
  String dailyconfirmed;
  String dailydeceased;
  String dailyrecovered;
  String date;
  String totalconfirmed;
  String totaldeceased;
  String totalrecovered;

  CasesTimeSery({
    this.dailyconfirmed,
    this.dailydeceased,
    this.dailyrecovered,
    this.date,
    this.totalconfirmed,
    this.totaldeceased,
    this.totalrecovered,
  });

  factory CasesTimeSery.fromJson(Map<String, dynamic> json) => CasesTimeSery(
        dailyconfirmed: json["dailyconfirmed"],
        dailydeceased: json["dailydeceased"],
        dailyrecovered: json["dailyrecovered"],
        date: json["date"],
        totalconfirmed: json["totalconfirmed"],
        totaldeceased: json["totaldeceased"],
        totalrecovered: json["totalrecovered"],
      );

  Map<String, dynamic> toJson() => {
        "dailyconfirmed": dailyconfirmed,
        "dailydeceased": dailydeceased,
        "dailyrecovered": dailyrecovered,
        "date": date,
        "totalconfirmed": totalconfirmed,
        "totaldeceased": totaldeceased,
        "totalrecovered": totalrecovered,
      };
}

class Statewise {
  String active;
  String confirmed;
  String deaths;
  String deltaconfirmed;
  String deltadeaths;
  String deltarecovered;
  String lastupdatedtime;
  String recovered;
  String state;
  String statecode;

  Statewise({
    this.active,
    this.confirmed,
    this.deaths,
    this.deltaconfirmed,
    this.deltadeaths,
    this.deltarecovered,
    this.lastupdatedtime,
    this.recovered,
    this.state,
    this.statecode,
  });

  StateStatistics toStatistics() {
    Statistic statistic = StateStatistics(name: this.state, code: this.statecode, regionType: RegionType.STATE);
    CaseData currentCD = CaseData();
    currentCD.confirmed = int.parse(this.confirmed);
    currentCD.active = int.parse(this.active);
    currentCD.recovered = int.parse(this.recovered);
    currentCD.death = int.parse(this.deaths);
    statistic.currentCaseData = currentCD;

    CaseData deltaCD = CaseData();
    deltaCD.confirmed = int.parse(this.deltaconfirmed);
    deltaCD.active = 0;
    deltaCD.recovered = int.parse(this.deltarecovered);
    deltaCD.death = int.parse(this.deltadeaths);
    statistic.deltaCaseData = deltaCD;

    return statistic;
  }

  factory Statewise.fromJson(Map<String, dynamic> json) => Statewise(
        active: json["active"],
        confirmed: json["confirmed"],
        deaths: json["deaths"],
        deltaconfirmed: json["deltaconfirmed"],
        deltadeaths: json["deltadeaths"],
        deltarecovered: json["deltarecovered"],
        lastupdatedtime: json["lastupdatedtime"],
        recovered: json["recovered"],
        state: json["state"],
        statecode: json["statecode"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "confirmed": confirmed,
        "deaths": deaths,
        "deltaconfirmed": deltaconfirmed,
        "deltadeaths": deltadeaths,
        "deltarecovered": deltarecovered,
        "lastupdatedtime": lastupdatedtime,
        "recovered": recovered,
        "state": state,
        "statecode": statecode,
      };
}

class Tested {
  String ckd7G;
  String source;
  String testsconductedbyprivatelabs;
  String totalindividualstested;
  String totalpositivecases;
  String totalsamplestested;
  String updatetimestamp;

  Tested({
    this.ckd7G,
    this.source,
    this.testsconductedbyprivatelabs,
    this.totalindividualstested,
    this.totalpositivecases,
    this.totalsamplestested,
    this.updatetimestamp,
  });

  factory Tested.fromJson(Map<String, dynamic> json) => Tested(
        ckd7G: json["_ckd7g"] == null ? null : json["_ckd7g"],
        source: json["source"],
        testsconductedbyprivatelabs: json["testsconductedbyprivatelabs"],
        totalindividualstested: json["totalindividualstested"],
        totalpositivecases: json["totalpositivecases"],
        totalsamplestested: json["totalsamplestested"],
        updatetimestamp: json["updatetimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "_ckd7g": ckd7G == null ? null : ckd7G,
        "source": source,
        "testsconductedbyprivatelabs": testsconductedbyprivatelabs,
        "totalindividualstested": totalindividualstested,
        "totalpositivecases": totalpositivecases,
        "totalsamplestested": totalsamplestested,
        "updatetimestamp": updatetimestamp,
      };
}
