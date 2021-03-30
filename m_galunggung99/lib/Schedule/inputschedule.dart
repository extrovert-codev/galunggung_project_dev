import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_galunggung99/_General/city.dart' as cityPage;
import 'package:m_galunggung99/_General/kelurahan.dart' as kelurahanPage;
import 'package:m_galunggung99/_General/kecamatan.dart' as kecamatanPage;
import 'package:m_galunggung99/_General/postalcode.dart' as postalcodePage;
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/Schedule/Model/inputschedule_model.dart';
import 'package:m_galunggung99/_General/activity.dart' as activityPage;
import 'package:m_galunggung99/Schedule/schedulelocation.dart'
    as schedulelocationPage;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../_GlobalScript.dart' as _globalScript;

class InputSchedule extends StatefulWidget {
  @override
  _InputScheduleState createState() => _InputScheduleState();
}

class _InputScheduleState extends State<InputSchedule> {
  TextEditingController txtBuyerName = TextEditingController();
  TextEditingController txtRemarks = TextEditingController();

  String myDate, myTime;
  DateTime valDate;
  TimeOfDay valTime;

  void refreshData() {
    //
    activityPage.activityIDSelected = '';
    activityPage.txtActivity.text = '';
    //
    valDate = null;
    valTime = null;
    txtBuyerName.text = '';
    txtRemarks.text = '';
    //
    provincePage.scheduleProvinceIDSelected = '';
    provincePage.txtScheduleProvince.text = '';
    cityPage.scheduleCityIDSelected = '';
    cityPage.txtScheduleCity.text = '';
    kelurahanPage.scheduleKelurahanIDSelected = '';
    kelurahanPage.txtScheduleKelurahan.text = '';
    kecamatanPage.scheduleKecamatanIDSelected = '';
    kecamatanPage.txtScheduleKecamatan.text = '';
    postalcodePage.schedulePostalCodeIDSelected = '';
    postalcodePage.txtSchedulePostalCode.text = '';
    schedulelocationPage.txtScheduleLocation.text = '';
    //
  }

  @override
  void initState() {
    super.initState();
    refreshData();
    myDate = 'Tanggal Kegiatan';
    myTime = 'Waktu Kegiatan';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text('Tambah Kegiatan', style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                color: Colors.white,
                child: Column(children: [
                  Expanded(
                      child: Container(
                          child: ListView(children: [
                    _selector(activityPage.txtActivity, 'Nama Kegiatan',
                        activityPage.Activity()),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Divider(height: 1, thickness: 1)),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (valDate == null)
                                ? myDate
                                : DateFormat('EEEE, dd MMMM yyyy')
                                    .format(valDate),
                            style: TextStyle(
                                color: (valDate == null)
                                    ? Colors.grey
                                    : Colors.black,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Divider(height: 1, thickness: 1)),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (valTime == null)
                                ? myTime
                                : valTime
                                    .toString()
                                    .replaceAll('TimeOfDay(', '')
                                    .replaceAll(')', ''),
                            style: TextStyle(
                                color: (valTime == null)
                                    ? Colors.grey
                                    : Colors.black,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      onTap: () => _selectTime(context),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Divider(height: 1, thickness: 1)),
                    _textField(txtBuyerName, 'Nama Calon Buyer',
                        TextInputType.name, TextInputAction.next),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Divider(height: 1, thickness: 1)),
                    _selector(
                        schedulelocationPage.txtScheduleLocation,
                        'Lokasi Kunjungan',
                        schedulelocationPage.ScheduleLocation()),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Divider(height: 1, thickness: 1)),
                    _textField(txtRemarks, 'Keterangan', TextInputType.text,
                        TextInputAction.done),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Divider(height: 1, thickness: 1))
                  ]))),
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 50,
                      child: Center(
                          child: GestureDetector(
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(44, 39, 59, 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text('Posting',
                                          style:
                                              TextStyle(color: Colors.white)))),
                              onTap: () {
                                _save();
                              })))
                ]))));
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (activityPage.txtActivity.text == '' ||
        valDate == null ||
        valTime == null ||
        txtBuyerName.text == '' ||
        schedulelocationPage.txtScheduleLocation.text == '' ||
        txtRemarks.text == '') {
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
      EasyLoading.show(status: 'Loading');
      Timer(Duration(seconds: 3), () {
        EasyLoading.dismiss();
        InputScheduleModel.execAPI(
                _globalScript.myEmpID,
                activityPage.activityIDSelected,
                valDate.toString(),
                valTime
                    .toString()
                    .replaceAll('TimeOfDay(', '')
                    .replaceAll(')', ''),
                txtBuyerName.text,
                schedulelocationPage.txtScheduleLocation.text,
                txtRemarks.text,
                _globalScript.myEmail)
            .then((value) {
          Alert(
              context: context,
              title: 'Horee..',
              desc: 'Kegiatan berhasil diposting! :)',
              type: AlertType.success,
              buttons: [
                DialogButton(
                    color: Color.fromARGB(255, 15, 193, 167),
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        refreshData();
                      });
                      Get.back();
                      Get.back();
                    })
              ]).show();
        });
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: (valDate == null) ? DateTime.now() : valDate,
        firstDate: DateTime(1945),
        lastDate: DateTime(2100));
    if (picked != null && picked != valDate)
      setState(() {
        valDate = picked;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: (valTime == null) ? TimeOfDay.now() : valTime,
    );
    if (picked != null)
      setState(() {
        valTime = picked;
      });
  }

  Container _selector(
      TextEditingController _controller, String _textLabel, Widget _page) {
    return Container(
        padding: EdgeInsets.only(left: 12, right: 10),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                  readOnly: true,
                  controller: _controller,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: _textLabel,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12)),
                  onTap: () =>
                      Get.to(_page, transition: Transition.rightToLeft)),
            ),
            Icon(Icons.navigate_next, color: Colors.grey)
          ],
        ));
  }

  Container _textField(TextEditingController _controller, String _textLabel,
      TextInputType _textInputType, TextInputAction _textInputAction) {
    return Container(
        padding: EdgeInsets.only(left: 12, right: 10),
        color: Colors.white,
        child: TextField(
            controller: _controller,
            style: TextStyle(fontSize: 12),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: _textLabel,
                labelStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            keyboardType: _textInputType,
            textInputAction: _textInputAction));
  }
}
