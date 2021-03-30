import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class ActivityModel {
  String activityID, name;

  ActivityModel({this.activityID, this.name});

  factory ActivityModel.getActivity(Map<String, dynamic> object) {
    return ActivityModel(
        activityID: object['activity_id'], name: object['name']);
  }

  static Future<List<ActivityModel>> execAPI() async {
    List<ActivityModel> activity = [];
    String apiURL = gScript.apiLink + '/Activity';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listActivity = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listActivity.length; i++) {
        activity.add(ActivityModel.getActivity(listActivity[i]));
      }
      return activity;
    } else {
      return null;
    }
  }
}
