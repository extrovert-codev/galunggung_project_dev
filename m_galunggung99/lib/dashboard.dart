import 'package:flutter/material.dart';
import 'package:m_galunggung99/Attendance/myattendance.dart';
import 'package:m_galunggung99/_GlobalScript.dart';
import 'package:m_galunggung99/Home/homedirut.dart';
import 'package:m_galunggung99/Listing/inputlisting.dart';
import 'package:m_galunggung99/Schedule/listschedule.dart';
import 'package:m_galunggung99/Home/homemarketing.dart';
import 'package:m_galunggung99/Home/homeoprasional.dart';
import 'package:m_galunggung99/Profil/profil.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int navSelectedIndex = 0;

  List pageList = [
    (myPositionID == '1' || myPositionID == '9')
        ? HomeDirut()
        : (myPositionID == '2' || myPositionID == '5' || myPositionID == '6')
            ? HomeMarketing()
            : (myPositionID == '3' || myPositionID == '4')
                ? HomeOprasional()
                : SizedBox(),
    ListSchedule(),
    MyAttendance(),
    InputListing(),
    Profil()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: pageList.elementAt(navSelectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: Colors.amber),
            currentIndex: navSelectedIndex,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color.fromRGBO(44, 39, 59, 1),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart_outlined), label: 'Kegiatan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fingerprint), label: 'Absensi'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_work_outlined), label: 'Listing'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined), label: 'Saya')
            ],
            onTap: (value) {
              setState(() {
                navSelectedIndex = value;
              });
            }));
  }
}
