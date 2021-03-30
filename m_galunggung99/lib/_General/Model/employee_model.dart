import 'dart:convert';

import 'package:m_galunggung99/_GlobalScript.dart' as gScript;
import 'package:http/http.dart' as http;

class EmployeeModel {
  String employeeID, name, image;

  EmployeeModel({this.employeeID, this.name, this.image});

  factory EmployeeModel.getEmployee(Map<String, dynamic> object) {
    return EmployeeModel(
        employeeID: object['employee_id'],
        name: object['name'],
        image: object['image']);
  }

  static Future<List<EmployeeModel>> execAPIAllEmployee() async {
    List<EmployeeModel> employee = [];
    String apiURL = gScript.apiLink + '/Employee';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listEmployee = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listEmployee.length; i++) {
        employee.add(EmployeeModel.getEmployee(listEmployee[i]));
      }
      return employee;
    } else {
      return null;
    }
  }

  static Future<EmployeeModel> execAPI(employeeID) async {
    String apiURL = gScript.apiLink + '/Employee?employee_id=$employeeID';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      var empData = (jsonObject as Map<String, dynamic>)['data'];

      return EmployeeModel.getEmployee(empData[0]);
    } else {
      return null;
    }
  }
}
