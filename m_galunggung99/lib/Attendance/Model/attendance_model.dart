import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class AttendanceModel {
  String attID, employeeID, time;

  AttendanceModel({this.attID, this.employeeID, this.time});

  // POST
  factory AttendanceModel.postAttendance(Map<String, dynamic> object) {
    return AttendanceModel(employeeID: object['employee_id']);
  }

  static Future<AttendanceModel> execAPIPost(String employeeID) async {
    String apiURL = apiLink + '/Attendance';
    var result = await http.post(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    }, body: {
      'employee_id': employeeID
    });
    var jsonObject = jsonDecode(result.body);

    return AttendanceModel.postAttendance(jsonObject);
  }
  // POST

  // PUT
  factory AttendanceModel.putAttendance(Map<String, dynamic> object) {
    return AttendanceModel(attID: object['attendance_id']);
  }

  static Future<AttendanceModel> execAPIPut(String attID) async {
    String apiURL = apiLink + '/Attendance';
    var result = await http.put(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    }, body: {
      'attendance_id': attID
    });
    var jsonObject = jsonDecode(result.body);

    return AttendanceModel.putAttendance(jsonObject);
  }
  // PUT
}
