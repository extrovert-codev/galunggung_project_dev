import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class PropertyModel {
  String propertyID, name;

  PropertyModel({this.propertyID, this.name});

  factory PropertyModel.getProperty(Map<String, dynamic> object) {
    return PropertyModel(
        propertyID: object['property_id'], name: object['name']);
  }

  static Future<List<PropertyModel>> execAPI() async {
    List<PropertyModel> property = [];
    String apiURL = gScript.apiLink + '/Property';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listProperty = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listProperty.length; i++) {
        property.add(PropertyModel.getProperty(listProperty[i]));
      }
      return property;
    } else {
      return null;
    }
  }
}
