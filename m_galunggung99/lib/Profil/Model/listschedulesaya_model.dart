import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class ListScheduleSayaModel {
  String activity, buyerName, marketing, date, time;

  ListScheduleSayaModel(
      {this.activity, this.buyerName, this.marketing, this.date, this.time});

  factory ListScheduleSayaModel.getListSchedule(Map<String, dynamic> object) {
    return ListScheduleSayaModel(
        activity: object['activity'],
        buyerName: object['buyername'],
        marketing: object['name'],
        date: object['date'],
        time: object['time']);
  }

  static Future<List<ListScheduleSayaModel>> execAPI(
      String empID, String date) async {
    List<ListScheduleSayaModel> activityMarketing = [];
    String apiURL = apiLink + '/Schedule?employee_id=$empID&date=$date';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listSchedule = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listSchedule.length; i++) {
        activityMarketing
            .add(ListScheduleSayaModel.getListSchedule(listSchedule[i]));
      }
      return activityMarketing;
    } else {
      return null;
    }
  }
}
