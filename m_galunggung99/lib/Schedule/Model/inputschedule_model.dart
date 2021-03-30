import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart' as gScript;

class InputScheduleModel {
  String empID,
      activityID,
      date,
      time,
      buyerName,
      location,
      remarks,
      useredited;

  InputScheduleModel(
      {this.empID,
      this.activityID,
      this.date,
      this.time,
      this.buyerName,
      this.location,
      this.remarks,
      this.useredited});

  factory InputScheduleModel.postKegiatan(Map<String, dynamic> object) {
    return InputScheduleModel(
        empID: object['employee_id'],
        activityID: object['activity_id'],
        date: object['date'],
        time: object['time'],
        buyerName: object['buyername'],
        location: object['location'],
        remarks: object['remarks'],
        useredited: object['useredited']);
  }

  static Future<InputScheduleModel> execAPI(
      String empID,
      String activityID,
      String date,
      String time,
      String buyerName,
      String location,
      String remarks,
      String useredited) async {
    String apiURL = gScript.apiLink + '/Schedule';
    var result = await http.post(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    }, body: {
      'employee_id': empID,
      'activity_id': activityID,
      'date': date,
      'time': time,
      'buyername': buyerName,
      'location': location,
      'remarks': remarks,
      'useredited': useredited
    });
    var jsonObject = jsonDecode(result.body);
    return InputScheduleModel.postKegiatan(jsonObject);
  }
}
