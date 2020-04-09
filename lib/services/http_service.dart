import 'dart:convert';

import 'package:covid/model/statistic.model.dart';
import 'package:covid/services/exchange/district_wise.model.dart';
import 'package:covid/services/exchange/nation_and_state_wide_res.model.dart';
import 'package:covid/services/map.service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:xml/xml.dart' as xml;
import 'package:xml/xml_events.dart' as xml_events;

class HttpService {
  Future<MapEntry> getData() async {
    String test = await rootBundle.loadString('assets/svgs/india3.svg');
    test = test.replaceAll("INAPFILL", "red");

    test = await MapService().indiaMap();

    print("calling internet to get data");
    Statistic statistic = await _getNationAndStateWideData();
    List<DistrictWiseRes> dres = await _getDistrictWideData(statistic);
    fillStateAndDistrictData(statistic, dres);
//    await Future.delayed(Duration(seconds: 10), () => print("delayed"));
    return MapEntry(statistic, test);
  }

  Future<Statistic> _getNationAndStateWideData() async {
    String url = "https://api.covid19india.org/data.json";
    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        NationAndStateWideRes res = NationAndStateWideRes.fromJson(body);
        Statistic statistic = res.toStatistics();
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
