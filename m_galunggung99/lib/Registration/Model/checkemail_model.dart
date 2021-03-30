import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class CheckEmailModel {
  String employeeID;

  CheckEmailModel({this.employeeID});

  factory CheckEmailModel.getCheckEmail(Map<String, dynamic> object) {
    return CheckEmailModel(employeeID: object['employee_id']);
  }

  static Future<CheckEmailModel> execAPI(String email) async {
    var emailData;
    String apiURL = gScript.apiLink + '/CheckEmail?email=$email';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      emailData = (jsonObject as Map<String, dynamic>)['data'];
      return CheckEmailModel.getCheckEmail(emailData[0]) ?? null;
    } else {
      return null;
    }
  }
}
