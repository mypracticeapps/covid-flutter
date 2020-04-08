import 'dart:convert';

import 'package:covid/model/statistic.model.dart';
import 'package:covid/services/exchange/district_wise.model.dart';
import 'package:covid/services/exchange/nation_and_state_wide_res.model.dart';
import 'package:http/http.dart';

class HttpService {
  Future<Statistic> getData() async {
    print("calling internet to get data");
    Statistic statistic = await _getNationAndStateWideData();
    List<DistrictWiseRes> dres = await _getDistrictWideData(statistic);
    fillStateAndDistrictData(statistic, dres);
//    await Future.delayed(Duration(seconds: 10), () => print("delayed"));
    return statistic;
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
