import 'dart:convert';

import 'package:covid/maps/MySvgBuilder.dart';
import 'package:covid/model/statistic.model.dart';
import 'package:covid/services/exchange/district_wise.model.dart';
import 'package:covid/services/exchange/nation_and_state_wide_res.model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:xml/xml.dart' as xml;
import 'package:xml/xml_events.dart' as xml_events;

class HttpService {
  Future<MapEntry> getData() async {
    print("calling internet to get data");
    IndiaStatistics statistic = await _getNationAndStateWideData();
    List<DistrictWiseRes> dres = await _getDistrictWideData(statistic);
    fillStateAndDistrictData(statistic, dres);

    // merge jk and la. after remove la.
    StateStatistics jk = statistic.states.firstWhere((st)=>st.code == "IN-JK");
    StateStatistics la = statistic.states.firstWhere((st)=>st.code == "IN-LA");
    statistic.states.remove(la);

    jk.currentCaseData.confirmed += la.currentCaseData.confirmed;
    jk.currentCaseData.active += la.currentCaseData.active;
    jk.currentCaseData.recovered += la.currentCaseData.recovered;
    jk.currentCaseData.death += la.currentCaseData.death;
    jk.deltaCaseData.confirmed += la.deltaCaseData.confirmed;
    jk.deltaCaseData.active += la.deltaCaseData.active;
    jk.deltaCaseData.recovered += la.deltaCaseData.recovered;
    jk.deltaCaseData.death += la.deltaCaseData.death;
    jk.districts.addAll(la.districts);

    String image = await MySvgBuilder(india:statistic).build();
    return MapEntry(statistic, image);
  }

  Future<Statistic> _getNationAndStateWideData() async {
    String url = "https://api.covid19india.org/data.json";
    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        NationAndStateWideRes res = NationAndStateWideRes.fromJson(body);
        IndiaStatistics statistic = res.toStatistics();
        return statistic;
      } else {
        throw "cannot get nation and state wise data";
      }
    } catch (e) {
      print(e);
      throw "cannot get nation and state wise data";
    }
  }

  Future<List<DistrictWiseRes>> _getDistrictWideData(Statistic statistic) async {
    String url = "https://api.covid19india.org/v2/state_district_wise.json";
    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        List<DistrictWiseRes> list = districtWiseResFromJson(response.body);
        return list;
      } else {
        throw "cannot get district data";
      }
    } catch (e) {
      print(e);
      throw "cannot get district data";
    }
  }
}
