import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class ListScheduleModel {
  String activity, buyerName, marketing, date, time;

  ListScheduleModel(
      {this.activity, this.buyerName, this.marketing, this.date, this.time});

  factory ListScheduleModel.getListSchedule(Map<String, dynamic> object) {
    return ListScheduleModel(
        activity: object['activity'],
        buyerName: object['buyername'],
        marketing: object['name'],
        date: object['date'],
        time: object['time']);
  }

  static Future<List<ListScheduleModel>> execAPI(String date) async {
    List<ListScheduleModel> activityMarketing = [];
    String apiURL = apiLink + '/Schedule?date=$date';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listSchedule = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listSchedule.length; i++) {
        activityMarketing
            .add(ListScheduleModel.getListSchedule(listSchedule[i]));
      }
      return activityMarketing;
    } else {
      return null;
    }
  }
}
