import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/employee_model.dart';

class Employee extends StatefulWidget {
  @override
  _EmployeeState createState() => _EmployeeState();
}

String employeeIDSelected;

class _EmployeeState extends State<Employee> {
  bool isLoading;

  TextEditingController txtEmployeeName = TextEditingController();

  List<dynamic> employeeID;
  List<dynamic> employeeName;

  Future refreshData() async {
    isLoading = true;
    employeeID = [];
    employeeName = [];

    EmployeeModel.execAPIAllEmployee().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            employeeID.add(value[i].employeeID);
            employeeName.add(value[i].name);
          }
        }
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Pegawai'),
          backgroundColor: Color.fromRGBO(44, 39, 59, 1),
          elevation: 0),
      body: (isLoading)
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: ListView.separated(
                  separatorBuilder: (context, i) => Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  itemCount: employeeID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(employeeName[i].toString(),
                                      style: TextStyle(fontSize: 14))),
                              (txtEmployeeName.text ==
                                      employeeName[i].toString())
                                  ? Icon(Icons.check_circle,
                                      color: Color.fromRGBO(44, 39, 59, 1))
                                  : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            employeeIDSelected = employeeID[i].toString();
                            txtEmployeeName.text = employeeName[i].toString();
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
