import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:m_galunggung99/dashboard.dart';
import 'package:m_galunggung99/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAda = false;
  _cekData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var empID = prefs.getString('employee_id');
    if (empID != null) {
      isAda = true;
      _gScript.myEmpID = empID;
      _gScript.myEmail = prefs.getString('email');
      _gScript.myName = prefs.getString('name');
      _gScript.myPositionID = prefs.getString('position_id');
    } else {
      isAda = false;
      _gScript.myEmpID = null;
      _gScript.myEmail = null;
      _gScript.myName = null;
      _gScript.myPositionID = null;
    }
    Timer(Duration(seconds: 3), () {
      if (isAda == true) {
        Get.off(Dashboard());
      } else {
        Get.off(Login());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _cekData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Container(
              width: 180,
              height: 180,
              child: Image(
                  image: AssetImage('images/logoGG99.png'),
                  fit: BoxFit.contain)),
          Text('PT. GALUNGGUNG 99', style: TextStyle(fontSize: 25))
        ]))));
  }
}
