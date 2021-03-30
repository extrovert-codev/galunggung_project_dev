import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/Attendance/myattendance.dart';
import 'package:m_galunggung99/Profil/listlistingmenusaya.dart';
import 'package:m_galunggung99/Profil/listschedulesaya.dart';
import 'package:m_galunggung99/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Saya', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0),
        body: Container(
            color: Colors.white,
            child: ListView(children: [
              _menu(Icons.show_chart, Colors.amber, 'Kegiatan Saya',
                  ListScheduleSaya()),
              Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Divider(height: 1, thickness: 1)),
              _menu(Icons.list, Colors.blue, 'Listingan Saya',
                  ListListingMenuSaya()),
              Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Divider(height: 1, thickness: 1)),
              _menu(
                  Icons.history, Colors.green, 'Absensi Saya', MyAttendance()),
              Container(color: Colors.grey[100], height: 7),
              //
              _menu(
                  Icons.person_outline, Colors.amber, 'Pengaturan Akun', null),
              Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Divider(height: 1, thickness: 1)),
              _menu(Icons.exit_to_app, Colors.red, 'Logout', Login()),
              Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Divider(height: 1, thickness: 1)),
            ])));
  }

  GestureDetector _menu(IconData _icon, Color _iconColors, _title, _page) {
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.only(left: 12, right: 10),
            color: Colors.white,
            height: 50,
            child: Row(children: [
              Expanded(
                  child: Row(children: [
                Icon(_icon, color: _iconColors),
                Text('  $_title')
              ])),
              Icon(Icons.navigate_next, color: Colors.grey)
            ])),
        onTap: () async {
          if (_title == 'Logout') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Get.off(_page);
          } else if (_title == 'Pengaturan Akun') {
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Opss..',
                content: Text('Sedang dalam tahap pengembangan'),
                buttons: [
                  DialogButton(
                      color: Color.fromRGBO(44, 39, 59, 1),
                      child: Text('OK', style: TextStyle(color: Colors.white)),
                      onPressed: () => Get.back())
                ]).show();
          } else {
            Get.to(_page, transition: Transition.rightToLeft);
          }
        });
  }
}
