import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/Attendance/Model/attendance_model.dart';
import 'package:m_galunggung99/Attendance/Model/getattendance_model.dart';
import 'package:m_galunggung99/_GlobalScript.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

double latitude = 0;
double longitude = 0;

void postAbsen(context) async {
  Map<Permission, PermissionStatus> permitStatus = await [
    Permission.location,
    Permission.camera,
    Permission.storage
  ].request();

  if (permitStatus[Permission.location].isGranted &&
      permitStatus[Permission.camera].isGranted &&
      permitStatus[Permission.storage].isGranted) {
    String hasilScan = await scanner.scan();

    if (hasilScan != '' && hasilScan != null) {
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      Timer(Duration(seconds: 3), () {
        EasyLoading.dismiss();
        if (latitude.toString().substring(0, 7) == '-6.9336' &&
            longitude.toString().substring(0, 7) == '107.627') {
          GetAttendanceModel.execAPI(
                  myEmpID,
                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  DateFormat('yyyy-MM-dd').format(DateTime.now()))
              .then((value) {
            if (value == null) {
              if (sha1.convert(utf8.encode(hasilScan)) ==
                  sha1.convert(utf8
                      .encode('0fe590bed2a6a6c7f239393e1ee0f56fe927f63b'))) {
                AttendanceModel.execAPIPost(myEmpID).then((value) {
                  Alert(
                      context: context,
                      title: 'Horee..',
                      desc: 'Absen masuk berhasil! :)',
                      type: AlertType.success,
                      buttons: [
                        DialogButton(
                            color: Color.fromARGB(255, 15, 193, 167),
                            child: Text('OK',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              hasilScan = '';
                              Get.back();
                            })
                      ]).show();
                });
              } else {
                Alert(
                    context: context,
                    title: 'Opss..',
                    desc: 'Absen gagal! :(',
                    type: AlertType.error,
                    buttons: [
                      DialogButton(
                          color: Color.fromARGB(255, 15, 193, 167),
                          child:
                              Text('OK', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            hasilScan = '';
                            Get.back();
                          })
                    ]).show();
              }
            } else {
              String attID = value.attID;
              String timeIn = value.timeIn;
              String timeOut = value.timeOut;

              if (timeIn != null && timeOut != null) {
                Alert(
                    context: context,
                    title: 'Opss..',
                    desc:
                        'Anda hari ini sudah melakukan absen keluar, dan anda tidak bisa melakukan absen lagi.',
                    type: AlertType.error,
                    buttons: [
                      DialogButton(
                          color: Color.fromARGB(255, 15, 193, 167),
                          child:
                              Text('OK', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            hasilScan = '';
                            Get.back();
                          })
                    ]).show();
              } else if (timeIn != null && timeOut == null) {
                AttendanceModel.execAPIPut(attID).then((value) {
                  Alert(
                      context: context,
                      title: 'Horee..',
                      desc: 'Absen keluar berhasil! :)',
                      type: AlertType.success,
                      buttons: [
                        DialogButton(
                            color: Color.fromARGB(255, 15, 193, 167),
                            child: Text('OK',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              hasilScan = '';
                              Get.back();
                            })
                      ]).show();
                });
              }
            }
          });
        } else {
          Alert(
              context: context,
              title: 'Opss..',
              desc: 'Absen gagal! :(',
              type: AlertType.error,
              buttons: [
                DialogButton(
                    color: Color.fromARGB(255, 15, 193, 167),
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      hasilScan = '';
                      Get.back();
                    })
              ]).show();
        }
      });
    }
  }
}

Digest antiHack(password) {
  return sha1.convert(utf8.encode(sha1
      .convert(utf8.encode(md5
          .convert(utf8.encode(md5
              .convert(utf8.encode(md5
                  .convert(utf8.encode(md5
                      .convert(utf8.encode(md5
                          .convert(utf8.encode(sha1
                              .convert(utf8.encode(sha1
                                  .convert(utf8.encode(password))
                                  .toString()))
                              .toString()))
                          .toString()))
                      .toString()))
                  .toString()))
              .toString()))
          .toString()))
      .toString()));
}
