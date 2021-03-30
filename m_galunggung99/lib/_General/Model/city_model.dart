import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class CityModel {
  String cityID, name;

  CityModel({this.cityID, this.name});

  factory CityModel.getCity(Map<String, dynamic> object) {
    return CityModel(cityID: object['city_id'], name: object['name']);
  }

  static Future<List<CityModel>> execAPI(String provinceID) async {
    List<CityModel> city = [];
    String apiURL = gScript.apiLink + '/City?province_id=$provinceID';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listCity = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listCity.length; i++) {
        city.add(CityModel.getCity(listCity[i]));
      }
      return city;
    } else {
      return null;
    }
  }
}
