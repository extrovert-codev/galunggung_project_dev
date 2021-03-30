import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_galunggung99/Attendance/Model/getattendance_model.dart';
import 'package:m_galunggung99/Config/location_service.dart';
import 'package:m_galunggung99/Listing/approvelisting.dart';
import 'package:m_galunggung99/_General/Model/employee_model.dart';
import 'package:m_galunggung99/_GlobalProcedureFunction.dart';
import 'package:m_galunggung99/Schedule/inputschedule.dart';
import 'package:m_galunggung99/_GlobalScript.dart';
import 'package:m_galunggung99/Attendance/myattendance.dart';
import 'package:m_galunggung99/Listing/inputlisting.dart';
import 'package:m_galunggung99/Schedule/listschedule.dart';
import 'package:m_galunggung99/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../_GlobalScript.dart' as _gScript;

class HomeOprasional extends StatefulWidget {
  @override
  _HomeOprasionalState createState() => _HomeOprasionalState();
}

class _HomeOprasionalState extends State<HomeOprasional> {
  bool isLoading;
  String dy, tm, dt, timeIn, timeOut, myImage;

  LocationService locationService = LocationService();

  Future refreshData() async {
    isLoading = true;
    setState(() {
      dy = DateFormat('EEEE').format(DateTime.now());
      tm = DateFormat('HH:mm').format(DateTime.now());
      dt = DateFormat('dd MMM yyyy').format(DateTime.now());
      timeIn = 'In';
      timeOut = 'Out';

      EmployeeModel.execAPI(_gScript.myEmpID).then((value) {
        if (value != null) {
          myImage = value.image;
        } else {
          myImage = null;
        }
      });
    });

    Timer.periodic(Duration(seconds: 1), (value) {
      setState(() {
        GetAttendanceModel.execAPI(
                _gScript.myEmpID,
                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                DateFormat('yyyy-MM-dd').format(DateTime.now()))
            .then((value) {
          if (value != null) {
            (value.timeIn != null)
                ? timeIn = 'In ' + value.timeIn.substring(0, 5)
                : timeIn = 'In';
            (value.timeOut != null)
                ? timeOut = 'Out ' + value.timeOut.substring(0, 5)
                : timeOut = 'Out';
          } else {
            timeIn = 'In';
            timeOut = 'Out';
          }
        });
        dy = DateFormat('EEEE').format(DateTime.now());
        tm = DateFormat('HH:mm').format(DateTime.now());
        dt = DateFormat('dd MMM yyyy').format(DateTime.now());
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  void initState() {
    refreshData();
    locationService.locationStream.listen((userLocation) {
      setState(() {
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (isLoading)
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Container(
                    color: Colors.white,
                    child: ListView(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        children: [
                          SizedBox(height: 10),
                          Container(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Container(
                                    width: 80,
                                    height: 80,
                                    child: Image(
                                        image:
                                            AssetImage('images/logoGG99.png'),
                                        fit: BoxFit.contain)),
                                Container(
                                    height: 80,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Selamat Datang,',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                          Text(myName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300))
                                        ]))
                              ])),
                          SizedBox(height: 10),
                          Column(children: [
                            // Header
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      child: Column(children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        height: 140,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(dy,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          Text(tm,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          Text(dt,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ]),
                                                    Center(
                                                        child: Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white),
                                                            child: (myImage ==
                                                                    null)
                                                                ? Icon(Icons.person,
                                                                    size: 60,
                                                                    color: Colors
                                                                        .grey)
                                                                : Image.network(
                                                                    'https://galunggung99.com/rest-api/galunggung-api/uploads/images/employee/' +
                                                                        myImage,
                                                                    fit: BoxFit
                                                                        .contain)))
                                                  ]),
                                              SizedBox(height: 25),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                        child: Center(
                                                            child: Text(timeIn,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14)))),
                                                    Text('|',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14)),
                                                    Expanded(
                                                        child: Center(
                                                            child: Text(timeOut,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14))))
                                                  ])
                                            ])),
                                    Container(
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))))
                                  ]))
                                ]),
                            SizedBox(height: 10),
                            // Header

                            // Body
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Row(children: [
                                  Expanded(
                                      child: GestureDetector(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: 55,
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Icon(
                                                        Icons.fingerprint,
                                                        size: 35,
                                                        color: Colors.amber)),
                                                Text('Post Absen',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                          onTap: () {
                                            postAbsen(context);
                                          })),
                                  Expanded(
                                      child: btnMenu('Absenku', Icons.history,
                                          MyAttendance())),
                                  Expanded(
                                      child: btnMenu(
                                          'Tambah Listing',
                                          Icons.home_work_rounded,
                                          InputListing()))
                                ])),
                            Container(
                                height: 90,
                                child: Row(children: [
                                  Expanded(
                                      child: btnMenu(
                                          'Approve Listing',
                                          Icons.playlist_add_check,
                                          ApproveListing())),
                                  Expanded(
                                      child: btnMenu('Tambah Kegiatan',
                                          Icons.add_chart, InputSchedule())),
                                  Expanded(
                                      child: btnMenu(
                                          'Lihat Kegiatan',
                                          Icons.show_chart_sharp,
                                          ListSchedule())),
                                ])),
                            Container(
                                height: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Row(children: [
                                  Expanded(
                                      child: btnMenu('Logout',
                                          Icons.exit_to_app, Login())),
                                  Expanded(child: SizedBox()),
                                  Expanded(child: SizedBox())
                                ]))
                            // Body
                          ])
                        ]))));
  }

  GestureDetector btnMenu(String _title, IconData _icons, _page) {
    return GestureDetector(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: 55,
              height: 55,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Icon(_icons, size: 35, color: Colors.amber)),
          Text(_title, style: TextStyle(fontWeight: FontWeight.bold))
        ]),
        onTap: () async {
          if (_title == 'Logout') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Get.off(_page);
          } else {
            Get.to(_page);
          }
        });
  }
}
