import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class PengaturanAkunImageModel {
  String employeeID, imagename, image;

  PengaturanAkunImageModel({this.employeeID, this.imagename, this.image});

  factory PengaturanAkunImageModel.pengaturanAkunImage(
      Map<String, dynamic> object) {
    return PengaturanAkunImageModel(
        employeeID: object['employee_id'],
        imagename: object['imagename'],
        image: object['image']);
  }

  static Future<PengaturanAkunImageModel> execAPIPut(
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
    return PengaturanAkunImageModel.pengaturanAkunImage(jsonObject);
  }
}
