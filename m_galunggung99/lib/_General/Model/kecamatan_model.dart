import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class KecamatanModel {
  String kecamatanID, name;

  KecamatanModel({this.kecamatanID, this.name});

  factory KecamatanModel.getKecamatan(Map<String, dynamic> object) {
    return KecamatanModel(
        kecamatanID: object['kecamatan_id'], name: object['name']);
  }

  static Future<List<KecamatanModel>> execAPI(String cityID) async {
    List<KecamatanModel> kecamatan = [];
    String apiURL = gScript.apiLink + '/Kecamatan?city_id=$cityID';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listKecamatan =
          (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listKecamatan.length; i++) {
        kecamatan.add(KecamatanModel.getKecamatan(listKecamatan[i]));
      }
      return kecamatan;
    } else {
      return null;
    }
  }
}
