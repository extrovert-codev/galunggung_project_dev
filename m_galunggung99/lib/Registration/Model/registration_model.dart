import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class RegistrationModel {
  String employeeID,
      firstName,
      lastName,
      address,
      placeofbirth,
      dob,
      noktp,
      positionID,
      phone,
      password,
      active;

  RegistrationModel(
      {this.employeeID,
      this.firstName,
      this.lastName,
      this.address,
      this.placeofbirth,
      this.dob,
      this.noktp,
      this.positionID,
      this.phone,
      this.password,
      this.active});

  factory RegistrationModel.putRegistration(Map<String, dynamic> object) {
    return RegistrationModel(
        employeeID: object['employee_id'],
        firstName: object['firstname'],
        lastName: object['lastname'],
        address: object['address'],
        placeofbirth: object['placeofbirth'],
        dob: object['dob'],
        noktp: object['noktp'],
        positionID: object['position_id'],
        phone: object['phone'],
        password: object['password'],
        active: object['active']);
  }

  static Future<RegistrationModel> execAPIPut(
      String employeeID,
      firstName,
      lastName,
      address,
      placeofbirth,
      dob,
      noktp,
      positionID,
      phone,
      password,
      active) async {
    String apiURL = apiLink + '/EditEmployee';
    var result = await http.put(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    }, body: {
      'employee_id': employeeID,
      'firstname': firstName,
      'lastname': lastName,
      'address': address,
      'placeofbirth': placeofbirth,
      'dob': dob,
      'noktp': noktp,
      'position_id': positionID,
      'phone': phone,
      'password': password,
      'active': active
    });
    var jsonObject = jsonDecode(result.body);

    return RegistrationModel.putRegistration(jsonObject);
  }
}
