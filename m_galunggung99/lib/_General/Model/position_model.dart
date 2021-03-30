import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class PositionModel {
  String positionID, name;

  PositionModel({this.positionID, this.name});

  factory PositionModel.getPosition(Map<String, dynamic> object) {
    return PositionModel(
        positionID: object['position_id'], name: object['name']);
  }

  static Future<List<PositionModel>> execAPI() async {
    List<PositionModel> position = [];
    String apiURL = gScript.apiLink + '/Position';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listPosition = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listPosition.length; i++) {
        position.add(PositionModel.getPosition(listPosition[i]));
      }
      return position;
    } else {
      return null;
    }
  }
}
