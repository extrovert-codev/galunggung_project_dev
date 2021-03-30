import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class DayModel {
  String dayID, name;

  DayModel({this.dayID, this.name});

  factory DayModel.getDay(Map<String, dynamic> object) {
    return DayModel(dayID: object['day_id'], name: object['name']);
  }

  static Future<List<DayModel>> execAPI() async {
    List<DayModel> day = [];
    String apiURL = gScript.apiLink + '/Day';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listDay = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listDay.length; i++) {
        day.add(DayModel.getDay(listDay[i]));
      }
      return day;
    } else {
      return null;
    }
  }
}
