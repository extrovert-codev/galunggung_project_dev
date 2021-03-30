import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/_General/city.dart' as cityPage;
import 'package:m_galunggung99/_General/kecamatan.dart' as kecamatanPage;
import 'package:m_galunggung99/_General/kelurahan.dart' as kelurahanPage;
import 'package:m_galunggung99/_General/postalcode.dart' as postalcodePage;
import 'package:rflutter_alert/rflutter_alert.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

TextEditingController txtAddress = TextEditingController();
TextEditingController txtTempatTinggal = TextEditingController();

class _AddressState extends State<Address> {
  Future refreshData() async {
    setState(() {
      provincePage.addressProvinceIDSelected = '';
      cityPage.addressCityIDSelected = '';
      kecamatanPage.addressKecamatanIDSelected = '';
      kelurahanPage.addressKelurahanIDSelected = '';
      postalcodePage.addressPostalCodeIDSelected = '';

      provincePage.txtAddressProvince.text = '';
      cityPage.txtAddressCity.text = '';
      kecamatanPage.txtAddressKecamatan.text = '';
      kelurahanPage.txtAddressKelurahan.text = '';
      postalcodePage.txtAddressPostalCode.text = '';
      txtAddress.text = '';
      txtTempatTinggal.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Alamat Rumah'),
            backgroundColor: Color.fromRGBO(44, 39, 59, 1),
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (provincePage.txtAddressProvince.text != '' ||
                      txtTempatTinggal.text != '') {
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
                    _submit();
                  })
            ]),
        body: SingleChildScrollView(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                    color: Colors.white,
                    child: Column(children: [
                      _selector(provincePage.txtAddressProvince, 'Provinsi',
                          provincePage.Province()),
                      Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Divider(height: 1, thickness: 1)),
                      _selector(cityPage.txtAddressCity, 'Kota/Kabupaten',
                          cityPage.City()),
                      Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Divider(height: 1, thickness: 1)),
                      _selector(kecamatanPage.txtAddressKecamatan, 'Kecamatan',
                          kecamatanPage.Kecamatan()),
                      Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Divider(height: 1, thickness: 1)),
                      _selector(kelurahanPage.txtAddressKelurahan, 'Kelurahan',
                          kelurahanPage.Kelurahan()),
                      Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Divider(height: 1, thickness: 1)),
                      _selector(postalcodePage.txtAddressPostalCode, 'Kode Pos',
                          postalcodePage.PostalCode()),
                      Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Divider(height: 1, thickness: 1)),
                      _textField(
                          txtTempatTinggal,
                          'Nama Jalan, Gedung, No. Rumah/Unit',
                          TextInputType.streetAddress,
                          TextInputAction.done)
                    ])))));
  }

  void _submit() {
    if (provincePage.txtAddressProvince.text == '' ||
        cityPage.txtAddressCity.text == '' ||
        kecamatanPage.txtAddressKecamatan.text == '' ||
        kelurahanPage.txtAddressKelurahan.text == '' ||
        postalcodePage.txtAddressPostalCode.text == '' ||
        txtTempatTinggal.text == '') {
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
      txtAddress.text = txtTempatTinggal.text +
          ', ' +
          postalcodePage.txtAddressPostalCode.text +
          ', ' +
          kelurahanPage.txtAddressKelurahan.text +
          ', ' +
          kecamatanPage.txtAddressKecamatan.text +
          ', ' +
          cityPage.txtAddressCity.text +
          ', ' +
          provincePage.txtAddressProvince.text;
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
            onSubmitted: (value) {
              _submit();
            }));
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
                    provincePage.isPage = 'Address';
                    Get.to(_page, transition: Transition.rightToLeft);
                  })),
          Icon(Icons.navigate_next, color: Colors.grey)
        ]));
  }
}
