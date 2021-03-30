import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/_General/city.dart' as cityPage;
import 'package:m_galunggung99/_General/kecamatan.dart' as kecamatanPage;
import 'package:m_galunggung99/_General/kelurahan.dart' as kelurahanPage;
import 'package:m_galunggung99/_General/postalcode.dart' as postalcodePage;

import 'package:rflutter_alert/rflutter_alert.dart';

class PropertyAddress extends StatefulWidget {
  @override
  _PropertyAddressState createState() => _PropertyAddressState();
}

TextEditingController txtPropertyAddress = TextEditingController();
TextEditingController txtAlamatTanah = TextEditingController();

class _PropertyAddressState extends State<PropertyAddress> {
  Future refreshData() async {
    setState(() {
      provincePage.propAddressProvinceIDSelected = '';
      cityPage.propAddressCityIDSelected = '';
      kecamatanPage.propAddressKecamatanIDSelected = '';
      kelurahanPage.propAddressKelurahanIDSelected = '';
      postalcodePage.propAddressPostalCodeIDSelected = '';

      provincePage.txtPropAddressProvince.text = '';
      cityPage.txtPropAddressCity.text = '';
      kecamatanPage.txtPropAddressKecamatan.text = '';
      kelurahanPage.txtPropAddressKelurahan.text = '';
      postalcodePage.txtPropAddressPostalCode.text = '';
      txtPropertyAddress.text = '';
      txtAlamatTanah.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Alamat Property'),
            backgroundColor: Color.fromRGBO(44, 39, 59, 1),
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back), onPressed: () => _save()),
            actions: [
              IconButton(icon: Icon(Icons.check), onPressed: () => _save())
            ]),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                color: Colors.white,
                child: Column(children: [
                  _selector(provincePage.txtPropAddressProvince, 'Provinsi',
                      provincePage.Province()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(cityPage.txtPropAddressCity, 'Kota/Kabupaten',
                      cityPage.City()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(kecamatanPage.txtPropAddressKecamatan, 'Kecamatan',
                      kecamatanPage.Kecamatan()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(kelurahanPage.txtPropAddressKelurahan, 'Kelurahan',
                      kelurahanPage.Kelurahan()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(postalcodePage.txtPropAddressPostalCode, 'Kode Pos',
                      postalcodePage.PostalCode()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(
                      txtAlamatTanah,
                      'Nama Jalan, Gedung, No. Rumah/Unit',
                      TextInputType.streetAddress,
                      TextInputAction.done),
                ])),
          ),
        ));
  }

  void _save() {
    if (provincePage.txtPropAddressProvince.text == '' ||
        cityPage.txtPropAddressCity.text == '' ||
        kecamatanPage.txtPropAddressKecamatan.text == '' ||
        kelurahanPage.txtPropAddressKelurahan.text == '' ||
        postalcodePage.txtPropAddressPostalCode.text == '' ||
        txtAlamatTanah.text == '') {
      Alert(
          context: context,
          title: 'Peringatan',
          desc: 'Harap lengkapi data!',
          type: AlertType.warning,
          buttons: [
            DialogButton(
                color: Color.fromRGBO(44, 39, 59, 1),
                child: Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () => Get.back())
          ]).show();
    } else {
      txtPropertyAddress.text = txtAlamatTanah.text +
          ', ' +
          postalcodePage.txtPropAddressPostalCode.text +
          ', ' +
          kelurahanPage.txtPropAddressKelurahan.text +
          ', ' +
          kecamatanPage.txtPropAddressKecamatan.text +
          ', ' +
          cityPage.txtPropAddressCity.text +
          ', ' +
          provincePage.txtPropAddressProvince.text;
      Get.back();
    }
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
            textInputAction: _textInputAction,
            onSubmitted: (value) => _save()));
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
                    provincePage.isPage = 'Property Address';
                    Get.to(_page, transition: Transition.rightToLeft);
                  })),
          Icon(Icons.navigate_next, color: Colors.grey)
        ]));
  }
}
