import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class LegalityModel {
  String legalityID, name;

  LegalityModel({this.legalityID, this.name});

  factory LegalityModel.getLegality(Map<String, dynamic> object) {
    return LegalityModel(
        legalityID: object['legality_id'], name: object['name']);
  }

  static Future<List<LegalityModel>> execAPI() async {
    List<LegalityModel> legality = [];
    String apiURL = gScript.apiLink + '/Legality';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);

      List<dynamic> listLegality = (jsonObject as Map<String, dynamic>)['data'];
      for (int i = 0; i < listLegality.length; i++) {
        legality.add(LegalityModel.getLegality(listLegality[i]));
      }
      return legality;
    } else {
      return null;
    }
  }
}
