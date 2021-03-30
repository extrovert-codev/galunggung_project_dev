import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class ProvinceModel {
  String provinceID, name;

  ProvinceModel({this.provinceID, this.name});

  factory ProvinceModel.getProvince(Map<String, dynamic> object) {
    return ProvinceModel(
        provinceID: object['province_id'], name: object['name']);
  }

  static Future<List<ProvinceModel>> execAPI() async {
    List<ProvinceModel> province = [];
    String apiURL = gScript.apiLink + '/Province';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listProvince = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listProvince.length; i++) {
        province.add(ProvinceModel.getProvince(listProvince[i]));
      }
      return province;
    } else {
      return null;
    }
  }
}
