import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/Registration/Model/checkemail_model.dart';
import 'package:m_galunggung99/Registration/registration.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckEmail extends StatefulWidget {
  @override
  _CheckEmailState createState() => _CheckEmailState();
}

String empID;

class _CheckEmailState extends State<CheckEmail> {
  TextEditingController txtEmail = TextEditingController();

  CheckEmailModel checkEmailModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Buat Akun', style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0),
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Center(
                    child: SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 150,
                                      height: 150,
                                      child: Image(
                                          image:
                                              AssetImage('images/logoGG99.png'),
                                          fit: BoxFit.contain)),
                                  Text('Validasi Email',
                                      style: TextStyle(fontSize: 30)),
                                  SizedBox(height: 15),
                                  Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                          child: TextField(
                                              controller: txtEmail,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'example@galunggung99.com',
                                                  prefixIcon: Icon(Icons.mail),
                                                  border: InputBorder.none),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.go,
                                              onSubmitted: (value) =>
                                                  _lanjutkan()))),
                                  GestureDetector(
                                      child: Container(
                                          margin: EdgeInsets.only(top: 20),
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(44, 39, 59, 1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text('Lanjutkan',
                                                  style: TextStyle(
                                                      color: Colors.white)))),
                                      onTap: () => _lanjutkan())
                                ])))))));
  }

  void _lanjutkan() {
    FocusScope.of(context).unfocus();
    if (txtEmail.text == '') {
      Alert(
          context: context,
          type: AlertType.error,
          title: 'Opss..',
          content: Text('Harap isi emailnya terlebih dahulu'),
          buttons: [
            DialogButton(
                color: Color.fromRGBO(44, 39, 59, 1),
                child: Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () => Get.back())
          ]).show();
    } else {
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      CheckEmailModel.execAPI(txtEmail.text).then((value) {
        checkEmailModel = value;
        if (checkEmailModel == null) {
          EasyLoading.dismiss();
          Alert(
              context: context,
              type: AlertType.error,
              title: 'Opss..',
              content: Text('Email tidak valid!'),
              buttons: [
                DialogButton(
                    color: Color.fromRGBO(44, 39, 59, 1),
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                    onPressed: () => Get.back())
              ]).show();
        } else {
          EasyLoading.dismiss();
          empID = checkEmailModel.employeeID;
          Get.to(Registration(), transition: Transition.rightToLeft);
        }
      });
    }
  }
}
