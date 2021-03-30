import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class KelurahanModel {
  String kelurahanID, name;

  KelurahanModel({this.kelurahanID, this.name});

  factory KelurahanModel.getKelurahan(Map<String, dynamic> object) {
    return KelurahanModel(
        kelurahanID: object['kelurahan_id'], name: object['name']);
  }

  static Future<List<KelurahanModel>> execAPI(String kecamatanID) async {
    List<KelurahanModel> kelurahan = [];
    String apiURL = gScript.apiLink + '/Kelurahan?kecamatan_id=$kecamatanID';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listKelurahan =
          (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listKelurahan.length; i++) {
        kelurahan.add(KelurahanModel.getKelurahan(listKelurahan[i]));
      }
      return kelurahan;
    } else {
      return null;
    }
  }
}
