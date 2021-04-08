import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class LoginModel {
  String employeeID, name, email, password, positionID, image, onesignalID;

  LoginModel(
      {this.employeeID,
      this.name,
      this.email,
      this.password,
      this.positionID,
      this.image,
      this.onesignalID});

  factory LoginModel.getLogin(Map<String, dynamic> object) {
    return LoginModel(
        employeeID: object['employee_id'],
        name: object['firstname'] + ' ' + object['lastname'],
        email: object['email'],
        password: object['password'],
        positionID: object['position_id'],
        image: object['image'],
        onesignalID: object['onesignal_id']);
  }

  static Future<LoginModel> execAPI(String email) async {
    var loginData;
    String apiURL = gScript.apiLink + '/Login?email=$email';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      loginData = (jsonObject as Map<String, dynamic>)['data'];
      return LoginModel.getLogin(loginData[0]);
    } else {
      return null;
    }
  }
}
