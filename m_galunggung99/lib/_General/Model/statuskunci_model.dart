import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class StatusKunciModel {
  String statusKunciID, name;

  StatusKunciModel({this.statusKunciID, this.name});

  factory StatusKunciModel.getStatusKunci(Map<String, dynamic> object) {
    return StatusKunciModel(
        statusKunciID: object['statuskunci_id'], name: object['name']);
  }

  static Future<List<StatusKunciModel>> execAPI() async {
    List<StatusKunciModel> statusKunci = [];
    String apiURL = gScript.apiLink + '/StatusKunci';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listStatusKunci =
          (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listStatusKunci.length; i++) {
        statusKunci.add(StatusKunciModel.getStatusKunci(listStatusKunci[i]));
      }
      return statusKunci;
    } else {
      return null;
    }
  }
}
