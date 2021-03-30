import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_galunggung99/Profil/Model/listschedulesaya_model.dart';
import 'package:m_galunggung99/Schedule/inputschedule.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class ListScheduleSaya extends StatefulWidget {
  @override
  _ListScheduleSayaState createState() => _ListScheduleSayaState();
}

class _ListScheduleSayaState extends State<ListScheduleSaya> {
  bool isLoading;
  List<dynamic> txtKegiatan, txtBuyerName, txtMarketing, txtDate, txtTime;

  DateTime valDate;

  Future refreshData() async {
    isLoading = true;
    setState(() {
      valDate = DateTime.now();
      txtKegiatan = [];
      txtBuyerName = [];
      txtMarketing = [];
      txtDate = [];
      txtTime = [];

      ListScheduleSayaModel.execAPI(
              _gScript.myEmpID, DateFormat('yyyy-MM-dd').format(valDate))
          .then((value) {
        setState(() {
          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              txtKegiatan.add(value[i].activity);
              txtBuyerName.add(value[i].buyerName);
              txtMarketing.add(value[i].marketing);
              txtDate.add(value[i].date);
              txtTime.add(value[i].time);
            }
          }
          isLoading = false;
        });
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
            title: Text('Daftar Kegiatan Saya',
                style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => Get.to(InputSchedule()).then((value) {
                        isLoading = true;
                        ListScheduleSayaModel.execAPI(_gScript.myEmpID,
                                DateFormat('yyyy-MM-dd').format(valDate))
                            .then((value) {
                          setState(() {
                            txtKegiatan = [];
                            txtBuyerName = [];
                            txtMarketing = [];
                            txtDate = [];
                            txtTime = [];

                            if (value != null) {
                              for (int i = 0; i < value.length; i++) {
                                txtKegiatan.add(value[i].activity);
                                txtBuyerName.add(value[i].buyerName);
                                txtMarketing.add(value[i].marketing);
                                txtDate.add(value[i].date);
                                txtTime.add(value[i].time);
                              }
                            }
                            isLoading = false;
                          });
                        });
                      }))
            ]),
        body: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                  height: 70,
                  margin: EdgeInsets.all(10),
                  child: Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(44, 39, 59, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          DateFormat('MMM yyyy')
                                              .format(valDate),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      Icon(Icons.keyboard_arrow_down,
                                          color: Colors.white)
                                    ]),
                                onTap: () => showMonthPicker(
                                            context: context,
                                            initialDate: valDate)
                                        .then((value) {
                                      setState(() {
                                        isLoading = true;
                                        valDate = value;

                                        ListScheduleSayaModel.execAPI(
                                                _gScript.myEmpID,
                                                DateFormat('yyyy-MM-dd')
                                                    .format(valDate))
                                            .then((value) {
                                          setState(() {
                                            txtKegiatan = [];
                                            txtBuyerName = [];
                                            txtMarketing = [];
                                            txtDate = [];
                                            txtTime = [];

                                            if (value != null) {
                                              for (int i = 0;
                                                  i < value.length;
                                                  i++) {
                                                txtKegiatan
                                                    .add(value[i].activity);
                                                txtBuyerName
                                                    .add(value[i].buyerName);
                                                txtMarketing
                                                    .add(value[i].marketing);
                                                txtDate.add(value[i].date);
                                                txtTime.add(value[i].time);
                                              }
                                            }
                                            isLoading = false;
                                          });
                                        });
                                      });
                                    })),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Date',
                                      style: TextStyle(color: Colors.white)),
                                  Text('Schedule',
                                      style: TextStyle(color: Colors.white))
                                ])
                          ]))),
              Expanded(
                  child: (isLoading)
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 25),
                              itemCount: txtKegiatan.length,
                              itemBuilder: (context, i) {
                                return _scheduleData(i);
                              })))
            ])));
  }

  Container _scheduleData(int i) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 70,
        child: TimelineTile(
            indicatorStyle: IndicatorStyle(width: 10, color: Colors.amber),
            afterLineStyle: LineStyle(thickness: 0),
            beforeLineStyle: LineStyle(thickness: 0),
            isFirst: true,
            isLast: true,
            endChild: Row(children: [
              Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            DateFormat('dd')
                                .format(DateTime.parse(txtDate[i]))
                                .toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        SizedBox(height: 3),
                        Text(
                            DateFormat('E')
                                .format(DateTime.parse(txtDate[i]))
                                .toString(),
                            style: TextStyle(fontSize: 15))
                      ])),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 10),
                      child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(44, 39, 59, 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(children: [
                            Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(txtKegiatan[i],
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(height: 10),
                                  Text(txtTime[i].toString().substring(0, 5),
                                      style: TextStyle(color: Colors.white))
                                ])),
                            Expanded(
                                child: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                  Text(
                                      'A.N ' +
                                          txtBuyerName[i]
                                              .toString()
                                              .split(' ')[0],
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(height: 10),
                                  Text(txtMarketing[i].toString().split(' ')[0],
                                      style: TextStyle(color: Colors.amber))
                                ])))
                          ]))))
            ])));
  }
}
