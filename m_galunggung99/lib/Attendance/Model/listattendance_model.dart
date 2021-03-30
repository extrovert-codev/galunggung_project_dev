import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class ListAttendanceModel {
  String attID, name, image, attRemarks, date, timeIn, timeOut;

  ListAttendanceModel(
      {this.attID,
      this.name,
      this.image,
      this.attRemarks,
      this.date,
      this.timeIn,
      this.timeOut});

  factory ListAttendanceModel.getAttendance(Map<String, dynamic> object) {
    return ListAttendanceModel(
        attID: object['attendance_id'],
        name: object['name'],
        image: object['image'],
        attRemarks: object['attendanceremarks'],
        date: object['date'],
        timeIn: object['timein'],
        timeOut: object['timeout']);
  }

  // Personal
  static Future<List<ListAttendanceModel>> execAPIPersonal(
      String empID, String sdate, String edate) async {
    String apiURL = apiLink +
        '/Attendance?employee_id=$empID&startdate=$sdate&enddate=$edate';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);

      List<dynamic> listAtt = (jsonObject as Map<String, dynamic>)['data'];
      List<ListAttendanceModel> att = [];
      for (int i = 0; i < listAtt.length; i++) {
        att.add(ListAttendanceModel.getAttendance(listAtt[i]));
      }
      return att;
    } else {
      return null;
    }
  }

  // Employee
  static Future<List<ListAttendanceModel>> execAPI(
      String sdate, String edate) async {
    String apiURL = apiLink + '/Attendance?startdate=$sdate&enddate=$edate';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);

      List<dynamic> listAtt = (jsonObject as Map<String, dynamic>)['data'];
      List<ListAttendanceModel> att = [];
      for (int i = 0; i < listAtt.length; i++) {
        att.add(ListAttendanceModel.getAttendance(listAtt[i]));
      }
      return att;
    } else {
      return null;
    }
  }
}
