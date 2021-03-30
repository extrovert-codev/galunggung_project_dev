import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class PostalCodeModel {
  String postalCodeID, name;

  PostalCodeModel({this.postalCodeID, this.name});

  factory PostalCodeModel.getPostalCode(Map<String, dynamic> object) {
    return PostalCodeModel(
        postalCodeID: object['postalcode_id'], name: object['name']);
  }

  static Future<List<PostalCodeModel>> execAPI(String kelurahanID) async {
    List<PostalCodeModel> postalCode = [];
    String apiURL = gScript.apiLink + '/PostalCode?kelurahan_id=$kelurahanID';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listPostalCode =
          (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listPostalCode.length; i++) {
        postalCode.add(PostalCodeModel.getPostalCode(listPostalCode[i]));
      }
      return postalCode;
    } else {
      return null;
    }
  }
}
