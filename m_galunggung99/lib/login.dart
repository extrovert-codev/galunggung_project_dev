import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/Model/login_model.dart';
import 'package:m_galunggung99/Registration/checkemail.dart';
import 'package:m_galunggung99/_GlobalProcedureFunction.dart';
import 'package:m_galunggung99/dashboard.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPass = new TextEditingController();

  LoginModel loginModel;

  _simpan(_name, _empID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_name, _empID);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
                child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: SingleChildScrollView(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(children: [
                          Container(
                              child:
                                  Stack(alignment: Alignment.center, children: [
                            Container(
                                width: 130,
                                height: 130,
                                child: Image(
                                    image: AssetImage('images/logoGG99.png'),
                                    fit: BoxFit.contain)),
                            Center(
                                child: Container(
                                    margin: EdgeInsets.only(top: 130),
                                    child: Text('PT. GALUNGGUNG99',
                                        style: TextStyle(fontSize: 20))))
                          ])),
                          SizedBox(height: 30),
                          Column(children: [
                            TextField(
                                controller: txtEmail,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'example@galunggung99.com'),
                                style: TextStyle(fontSize: 14)),
                            Divider(height: 1, thickness: 1),
                            TextField(
                                obscureText: true,
                                controller: txtPass,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password'),
                                style: TextStyle(fontSize: 14),
                                onSubmitted: (value) => login())
                          ]),
                          SizedBox(height: 50),
                          GestureDetector(
                              child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromRGBO(44, 39, 59, 1)),
                                  child: Center(
                                      child: Text('Masuk',
                                          style:
                                              TextStyle(color: Colors.white)))),
                              onTap: () => login()),
                          SizedBox(height: 50),
                          Center(
                              child: GestureDetector(
                                  child: Container(
                                      child: Text(
                                          'Belum punya akun? Daftar disini.')),
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    EasyLoading.show(
                                        status: 'Loading',
                                        maskType: EasyLoadingMaskType.black);
                                    Timer(Duration(seconds: 1), () {
                                      EasyLoading.dismiss();
                                      Get.to(CheckEmail(),
                                          transition: Transition.rightToLeft);
                                    });
                                  }))
                        ]))))));
  }

  void login() {
    FocusScope.of(context).unfocus();
    if (txtEmail.text == '' || txtPass.text == '') {
      Alert(
          context: context,
          type: AlertType.error,
          title: 'Opss..',
          content: Text('Harap lengkapi data!'),
          buttons: [
            DialogButton(
                color: Color.fromRGBO(44, 39, 59, 1),
                child: Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () => Get.back())
          ]).show();
    } else {
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      LoginModel.execAPI(txtEmail.text).then((value) {
        loginModel = value;
        if (loginModel == null) {
          EasyLoading.dismiss();
          Alert(
              context: context,
              type: AlertType.error,
              title: 'Opss..',
              content: Text('Email atau password salah!'),
              buttons: [
                DialogButton(
                    color: Color.fromRGBO(44, 39, 59, 1),
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                    onPressed: () => Get.back())
              ]).show();
          setState(() {
            txtPass.text = '';
          });
        } else {
          EasyLoading.dismiss();
          if (antiHack(txtPass.text).toString() == loginModel.password) {
            _simpan('employee_id', loginModel.employeeID);
            _simpan('email', loginModel.email);
            _simpan('name', loginModel.name);
            _simpan('position_id', loginModel.positionID);
            _simpan('onesignal_id', loginModel.onesignalID);

            _gScript.myEmpID = loginModel.employeeID;
            _gScript.myEmail = loginModel.email;
            _gScript.myName = loginModel.name;
            _gScript.myPositionID = loginModel.positionID;
            _gScript.myOnesignal = loginModel.onesignalID;

            Get.off(Dashboard());
          } else {
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Opss..',
                content: Text('Email atau password salah!'),
                buttons: [
                  DialogButton(
                      color: Color.fromRGBO(44, 39, 59, 1),
                      child: Text('OK', style: TextStyle(color: Colors.white)),
                      onPressed: () => Get.back())
                ]).show();
            setState(() {
              txtPass.text = '';
            });
          }
        }
      });
    }
  }
}
