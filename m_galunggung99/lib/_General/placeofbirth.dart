import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/city.dart' as cityPage;
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:rflutter_alert/rflutter_alert.dart';

class PlaceOfBirth extends StatefulWidget {
  @override
  _PlaceOfBirthState createState() => _PlaceOfBirthState();
}

TextEditingController txtPlaceOfBirth = TextEditingController();

class _PlaceOfBirthState extends State<PlaceOfBirth> {
  Future refreshData() async {
    setState(() {
      provincePage.pobProvinceIDSelected = '';
      cityPage.pobCityIDSelected = '';

      provincePage.txtPobProvince.text = '';
      cityPage.txtPobCity.text = '';
      txtPlaceOfBirth.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Tempat Lahir'),
            backgroundColor: Color.fromRGBO(44, 39, 59, 1),
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (provincePage.txtPobProvince.text != '') {
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
                    if (provincePage.txtPobProvince.text == '' ||
                        cityPage.txtPobCity.text == '') {
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
                      txtPlaceOfBirth.text = cityPage.txtPobCity.text +
                          ', ' +
                          provincePage.txtPobProvince.text;
                      Get.back();
                    }
                  })
            ]),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                color: Colors.white,
                child: Column(children: [
                  _selector(provincePage.txtPobProvince, 'Provinsi',
                      provincePage.Province()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(
                      cityPage.txtPobCity, 'Kota/Kabupaten', cityPage.City()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1))
                ]))));
  }

  Container _selector(
      TextEditingController _controller, String _textLabel, Widget _page) {
    return Container(
        padding: EdgeInsets.only(left: 12, right: 10),
        color: Colors.white,
        child: Row(children: [
          Expanded(
              child: TextField(
                  readOnly: true,
                  controller: _controller,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: _textLabel,
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12)),
                  onTap: () {
                    provincePage.isPage = 'Place of Birth';
                    Get.to(_page, transition: Transition.rightToLeft);
                  })),
          Icon(Icons.navigate_next, color: Colors.grey)
        ]));
  }
}
