import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/_General/city.dart' as cityPage;
import 'package:m_galunggung99/_General/kecamatan.dart' as kecamatanPage;
import 'package:m_galunggung99/_General/kelurahan.dart' as kelurahanPage;
import 'package:m_galunggung99/_General/postalcode.dart' as postalcodePage;
import 'package:rflutter_alert/rflutter_alert.dart';

class ScheduleLocation extends StatefulWidget {
  @override
  _ScheduleLocationState createState() => _ScheduleLocationState();
}

TextEditingController txtScheduleLocation = TextEditingController();

class _ScheduleLocationState extends State<ScheduleLocation> {
  Future refreshData() async {
    setState(() {
      provincePage.scheduleProvinceIDSelected = '';
      cityPage.scheduleCityIDSelected = '';
      kecamatanPage.scheduleKecamatanIDSelected = '';
      kelurahanPage.scheduleKelurahanIDSelected = '';
      postalcodePage.schedulePostalCodeIDSelected = '';

      txtScheduleLocation.text = '';
      provincePage.txtScheduleProvince.text = '';
      cityPage.txtScheduleCity.text = '';
      kecamatanPage.txtScheduleKecamatan.text = '';
      kelurahanPage.txtScheduleKelurahan.text = '';
      postalcodePage.txtSchedulePostalCode.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Lokasi Kunjungan'),
            backgroundColor: Color.fromRGBO(44, 39, 59, 1),
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (provincePage.txtScheduleProvince.text != '') {
                    Alert(
                        context: context,
                        title: 'Peringatan',
                        desc:
                            'Perubahan tidak tersimpan. Yakin ingin buang perubahan?',
                        buttons: [
                          DialogButton(
                              color: Color.fromRGBO(44, 39, 59, 1),
                              child: Text('BATAL',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () => Get.back()),
                          DialogButton(
                              color: Color.fromRGBO(44, 39, 59, 1),
                              child: Text('BUANG',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                refreshData();
                                Get.back();
                                Get.back();
                              })
                        ]).show();
                  } else {
                    Get.back();
                  }
                }),
            actions: [
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    if (provincePage.txtScheduleProvince.text == '' ||
                        cityPage.txtScheduleCity.text == '' ||
                        kecamatanPage.txtScheduleKecamatan.text == '' ||
                        kelurahanPage.txtScheduleKelurahan.text == '' ||
                        postalcodePage.txtSchedulePostalCode.text == '') {
                      Alert(
                          context: context,
                          title: 'Peringatan',
                          desc: 'Harap lengkapi data!',
                          type: AlertType.warning,
                          buttons: [
                            DialogButton(
                                color: Color.fromRGBO(44, 39, 59, 1),
                                child: Text('OK',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () => Get.back())
                          ]).show();
                    } else {
                      txtScheduleLocation.text =
                          postalcodePage.txtSchedulePostalCode.text +
                              ', ' +
                              kelurahanPage.txtScheduleKelurahan.text +
                              ', ' +
                              kecamatanPage.txtScheduleKecamatan.text +
                              ', ' +
                              cityPage.txtScheduleCity.text +
                              ', ' +
                              provincePage.txtScheduleProvince.text;
                      Get.back();
                    }
                  })
            ]),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
              color: Colors.white,
              child: Column(children: [
                _selector(provincePage.txtScheduleProvince, 'Provinsi',
                    provincePage.Province()),
                Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Divider(height: 1, thickness: 1)),
                _selector(cityPage.txtScheduleCity, 'Kota/Kabupaten',
                    cityPage.City()),
                Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Divider(height: 1, thickness: 1)),
                _selector(kecamatanPage.txtScheduleKecamatan, 'Kecamatan',
                    kecamatanPage.Kecamatan()),
                Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Divider(height: 1, thickness: 1)),
                _selector(kelurahanPage.txtScheduleKelurahan, 'Kelurahan',
                    kelurahanPage.Kelurahan()),
                Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Divider(height: 1, thickness: 1)),
                _selector(postalcodePage.txtSchedulePostalCode, 'Kode Pos',
                    postalcodePage.PostalCode()),
              ])),
        ));
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
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _textLabel,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  onTap: () {
                    provincePage.isPage = 'Schedule';
                    Get.to(_page, transition: Transition.rightToLeft);
                  }),
            ),
            Icon(Icons.navigate_next, color: Colors.grey)
          ],
        ));
  }
}
