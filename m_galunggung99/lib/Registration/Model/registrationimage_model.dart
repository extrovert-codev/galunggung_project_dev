import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class RegistrationImageModel {
  String employeeID, imagename, image;

  RegistrationImageModel({this.employeeID, this.imagename, this.image});

  factory RegistrationImageModel.registrationImage(
      Map<String, dynamic> object) {
    return RegistrationImageModel(
        employeeID: object['employee_id'],
        imagename: object['imagename'],
        image: object['image']);
  }

  static Future<RegistrationImageModel> execAPIPut(
      String employeeID, String imagename, String image) async {
    String apiURL = _gScript.apiLink + '/EmployeeImage';

    var result = await http.put(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    }, body: {
      'employee_id': employeeID,
      'imagename': imagename,
      'image': image
    });

    var jsonObject = jsonDecode(result.body);
    return RegistrationImageModel.registrationImage(jsonObject);
  }
}
