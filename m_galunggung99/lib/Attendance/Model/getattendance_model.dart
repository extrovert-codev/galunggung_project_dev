import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class GetAttendanceModel {
  String attID, timeIn, timeOut;

  GetAttendanceModel({this.attID, this.timeIn, this.timeOut});

  factory GetAttendanceModel.getCheckAttendance(Map<String, dynamic> object) {
    return GetAttendanceModel(
        attID: object['attendance_id'],
        timeIn: object['timein'],
        timeOut: object['timeout']);
  }

  static Future<GetAttendanceModel> execAPI(
      String employeeID, String sdate, String edate) async {
    String apiURL = apiLink +
        '/Attendance?employee_id=$employeeID&startdate=$sdate&enddate=$edate';
    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      var absenData = (jsonObject as Map<String, dynamic>)['data'];

      return GetAttendanceModel.getCheckAttendance(absenData[0]);
    } else {
      return null;
    }
  }
}
