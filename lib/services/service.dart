import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/constants.dart';
import '../models/series_data_class.dart';

getWeeklyData(String code) async {
  DateTime dtnow = DateTime.now();
  DateTime dtweekback = DateTime(dtnow.year, dtnow.month, dtnow.day - 7);
  String startDate = '${dtweekback.day}-${dtweekback.month}-${dtweekback.year}';
  String endDate = '${dtnow.day}-${dtnow.month}-${dtnow.year}';
  var u =
      'https://evds2.tcmb.gov.tr/service/evds/series=TP.DK.$code.S.YTL&startDate=$startDate&endDate=$endDate&type=json&key=$apiKey&aggregationTypes=avg&formulas=0&frequency=1';
  var response = await http.get(Uri.parse(u));
  var map = jsonDecode(response.body);
  int totalCount = map['totalCount'];
  List<SeriesData> listdata = <SeriesData>[];
  for (int i = 0; i < totalCount; i++) {
    listdata.add(SeriesData.format(map, code, 'S', i, '0', 'avg', '5'));
  }
  return listdata;
}

Future<SeriesData> getEVDSUpdatedCurrencies(String code) async {
  DateTime dtnow = DateTime.now();
  String endDate;
  if (dtnow.weekday == 6) {
    endDate = '${dtnow.day - 1}-${dtnow.month}-${dtnow.year}';
  } else if (dtnow.weekday == 7) {
    endDate = '${dtnow.day - 2}-${dtnow.month}-${dtnow.year}';
  } else {
    endDate = '${dtnow.day}-${dtnow.month}-${dtnow.year}';
  }
  
  var u =
      'https://evds2.tcmb.gov.tr/service/evds/series=TP.DK.$code.S.YTL&startDate=$endDate&endDate=$endDate&type=json&key=$apiKey&aggregationTypes=avg&formulas=0&frequency=1';
  var response = await http.get(Uri.parse(u));
  var map = jsonDecode(response.body);
  SeriesData data = SeriesData.format(map, code, 'S', 0, '0', 'avg', '1');
  return data;
}
