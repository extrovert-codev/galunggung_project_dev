import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:m_galunggung99/Listing/Model/listingimage_model.dart';
import 'package:m_galunggung99/Listing/propertyaddress.dart' as propertyAddress;
import 'package:m_galunggung99/_General/legality.dart' as legalityPage;
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/_General/city.dart' as cityPage;
import 'package:m_galunggung99/_General/kecamatan.dart' as kecamatanPage;
import 'package:m_galunggung99/_General/kelurahan.dart' as kelurahanPage;
import 'package:m_galunggung99/_General/postalcode.dart' as postalcodePage;
import 'package:m_galunggung99/_General/statuskunci.dart' as statusKunciPage;
import 'package:m_galunggung99/_General/property.dart' as propertyPage;
import 'package:m_galunggung99/Listing/Model/inputlisting_model.dart';
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

class InputListing extends StatefulWidget {
  @override
  _InputListingState createState() => _InputListingState();
}

class _InputListingState extends State<InputListing> {
  TextEditingController txtNamaPemilik = TextEditingController();
  TextEditingController txtKTPPemilik = TextEditingController();
  TextEditingController txtAlamatPemilik = TextEditingController();
  TextEditingController txtPhonePemilik = TextEditingController();
  TextEditingController txtPekerjaanPemilik = TextEditingController();

  TextEditingController txtHargaProperty = TextEditingController();
  bool isNego;
  String valIsNego;
  TextEditingController txtLebarJalanDepan = TextEditingController();
  TextEditingController txtLuasTanah = TextEditingController();
  TextEditingController txtLuasBangunan = TextEditingController();
  TextEditingController txtJmlKamarTidur = TextEditingController();
  TextEditingController txtJmlKamarMandi = TextEditingController();
  TextEditingController txtKamarMandiPembantu = TextEditingController();
  TextEditingController txtRuangTamu = TextEditingController();
  TextEditingController txtRuangMakan = TextEditingController();
  TextEditingController txtRuangKeluarga = TextEditingController();
  TextEditingController txtRuangDapur = TextEditingController();
  TextEditingController txtTamanDepan = TextEditingController();
  TextEditingController txtTamanBelakang = TextEditingController();
  TextEditingController txtFurniture = TextEditingController();
  TextEditingController txtGarasi = TextEditingController();
  TextEditingController txtCarport = TextEditingController();
  String furnitureIDSelected;
  String garasiIDSelected;
  String carportIDSelected;

  int imgBox;
  List<File> imgList;
  List<String> base64Img;

  Future refreshData() async {
    txtNamaPemilik.text = '';
    txtKTPPemilik.text = '';
    txtAlamatPemilik.text = '';
    txtPhonePemilik.text = '';
    txtPekerjaanPemilik.text = '';

    propertyPage.propertyIDSelected = '';
    propertyPage.txtProperty.text = '';
    //
    provincePage.propAddressProvinceIDSelected = '';
    provincePage.txtPropAddressProvince.text = '';
    cityPage.propAddressCityIDSelected = '';
    cityPage.txtPropAddressCity.text = '';
    kecamatanPage.propAddressKecamatanIDSelected = '';
    kecamatanPage.txtPropAddressKecamatan.text = '';
    kelurahanPage.propAddressKelurahanIDSelected = '';
    kelurahanPage.txtPropAddressKelurahan.text = '';
    postalcodePage.propAddressPostalCodeIDSelected = '';
    postalcodePage.txtPropAddressPostalCode.text = '';
    propertyAddress.txtAlamatTanah.text = '';
    propertyAddress.txtPropertyAddress.text = '';
    //
    txtHargaProperty.text = '';
    isNego = false;
    valIsNego = '';
    txtLebarJalanDepan.text = '';
    txtLuasTanah.text = '';
    txtLuasBangunan.text = '';
    //
    statusKunciPage.statusKunciIDSelected = '';
    statusKunciPage.txtStatusKunci.text = '';
    //
    txtJmlKamarTidur.text = '';
    txtJmlKamarMandi.text = '';
    txtKamarMandiPembantu.text = '';
    txtRuangTamu.text = '';
    txtRuangMakan.text = '';
    txtRuangKeluarga.text = '';
    txtRuangDapur.text = '';
    txtTamanDepan.text = '';
    txtTamanBelakang.text = '';
    txtFurniture.text = '';
    txtGarasi.text = '';
    txtCarport.text = '';
    furnitureIDSelected = '';
    garasiIDSelected = '';
    carportIDSelected = '';
    //
    legalityPage.legalityIDSelected = '';
    legalityPage.txtLegality.text = '';
    legalityPage.fcLegalityIDSelected = '';
    legalityPage.txtFCLegality.text = '';
    //
    imgBox = 1;
    imgList = [];
    base64Img = [];
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Form Listing', style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                color: Colors.white,
                child: Container(
                    child: ListView(children: [
                  // Pemilik
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text('Biodata penjual',
                          style: TextStyle(fontSize: 12))),
                  _textField(txtNamaPemilik, 'Nama', TextInputType.name,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtKTPPemilik, 'No. KTP', TextInputType.number,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtAlamatPemilik, 'Alamat KTP', TextInputType.text,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtPhonePemilik, 'No Telp/HP', TextInputType.phone,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtPekerjaanPemilik, 'Pekerjaan',
                      TextInputType.text, TextInputAction.go),
                  // Pemilik
                  Container(color: Colors.grey[100], height: 7),

                  // Data
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text('Detail unit asset property',
                          style: TextStyle(fontSize: 12))),
                  _selector(propertyPage.txtProperty, 'Jenis Property',
                      propertyPage.Property()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(propertyAddress.txtPropertyAddress,
                      'Alamat Property', propertyAddress.PropertyAddress()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      color: Colors.white,
                      child: Row(children: [
                        Expanded(
                            child: _textField(
                                txtHargaProperty,
                                'Harga Property (Rp/M)',
                                TextInputType.number,
                                TextInputAction.next)),
                        Row(children: [
                          Checkbox(
                              value: isNego,
                              onChanged: (value) {
                                setState(() {
                                  isNego = value;
                                  (isNego == true)
                                      ? valIsNego = '1'
                                      : valIsNego = '0';
                                });
                              })
                        ]),
                        Text('Nego', style: TextStyle(fontSize: 12))
                      ])),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtLebarJalanDepan, 'Lebar Jalan Depan (M)',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtLuasTanah, 'Luas Tanah (M)',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtLuasBangunan, 'Luas Bangunan (M)',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(statusKunciPage.txtStatusKunci, 'Status Kunci',
                      statusKunciPage.StatusKunci()),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtJmlKamarTidur, 'Jumlah Kamar Tidur',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtJmlKamarMandi, 'Jumlah Kamar Mandi',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtKamarMandiPembantu, 'Kamar Mandi Pembantu',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtRuangTamu, 'Ruang Tamu', TextInputType.number,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtRuangMakan, 'Ruang Makan', TextInputType.number,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtRuangKeluarga, 'Ruang Keluarga',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtRuangDapur, 'Ruang Dapur', TextInputType.number,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtTamanDepan, 'Taman Depan', TextInputType.number,
                      TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _textField(txtTamanBelakang, 'Taman Belakang',
                      TextInputType.number, TextInputAction.next),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _booleanSelector(
                      context, txtFurniture, 'Furniture', 'Furniture'),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _booleanSelector(context, txtGarasi, 'Garasi', 'Garasi'),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _booleanSelector(context, txtCarport, 'Carport', 'Carport'),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(legalityPage.txtLegality, 'Legalitas',
                      legalityPage.Legality(legalityType: 'Legalitas')),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  _selector(
                      legalityPage.txtFCLegality,
                      'Foto Copy Legalitas',
                      legalityPage.Legality(
                          legalityType: 'Foto Copy Legalitas')),
                  Container(color: Colors.grey[100], height: 7),

                  Container(
                      color: Colors.white,
                      height: 200,
                      child: ListView.builder(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: imgBox,
                          itemBuilder: (context, i) {
                            return _uploadFoto(imgList, base64Img, i);
                          })),
                  Container(color: Colors.grey[100], height: 7),

                  // Data
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      height: 60,
                      child: Center(
                          child: GestureDetector(
                              child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(44, 39, 59, 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text('Kirim',
                                          style:
                                              TextStyle(color: Colors.white)))),
                              onTap: () {
                                _postListing();
                              })))
                ])))));
  }

  void _postImageListing() {
    for (int i = 0; i < imgList.length; i++) {
      String fileName = imgList[i].path.split('/').last;

      ListingImageModel.execAPIPostListingImage(
          _gScript.myEmpID, fileName, base64Img[i], '0', '', _gScript.myEmail);
    }
  }

  void _postListing() {
    FocusScope.of(context).unfocus();

    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
    Timer(Duration(seconds: 3), () {
      EasyLoading.dismiss();
      InputListingModel.execAPIPost(
              txtNamaPemilik.text,
              txtKTPPemilik.text,
              txtAlamatPemilik.text,
              txtPhonePemilik.text,
              txtPekerjaanPemilik.text,
              //
              _gScript.myEmpID,
              //
              propertyPage.propertyIDSelected,
              provincePage.propAddressProvinceIDSelected,
              cityPage.propAddressCityIDSelected,
              kecamatanPage.propAddressKecamatanIDSelected,
              kelurahanPage.propAddressKelurahanIDSelected,
              postalcodePage.propAddressPostalCodeIDSelected,
              propertyAddress.txtPropertyAddress.text,
              txtHargaProperty.text,
              valIsNego,
              txtLebarJalanDepan.text,
              txtLuasTanah.text,
              txtLuasBangunan.text,
              statusKunciPage.statusKunciIDSelected,
              txtJmlKamarTidur.text,
              txtJmlKamarMandi.text,
              txtKamarMandiPembantu.text,
              txtRuangTamu.text,
              txtRuangMakan.text,
              txtRuangKeluarga.text,
              txtRuangDapur.text,
              txtTamanDepan.text,
              txtTamanBelakang.text,
              furnitureIDSelected,
              garasiIDSelected,
              carportIDSelected,
              legalityPage.legalityIDSelected,
              legalityPage.fcLegalityIDSelected,
              '0',
              _gScript.myEmail)
          .then((value) {
        _postImageListing();
        Alert(
            context: context,
            title: 'Horee..',
            desc: 'Listing berhasil diposting! :)',
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
                  })
            ]).show();
      });
    });
  }

  Container _booleanSelector(BuildContext context,
      TextEditingController _controller, String _title, String _textLabel) {
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(title: Text(_title), children: [
                            SimpleDialogOption(
                                child: Text('Ada'),
                                onPressed: () {
                                  setState(() {
                                    _controller.text = 'Ada';
                                    if (_title == 'Furniture') {
                                      furnitureIDSelected = '1';
                                    } else if (_title == 'Garasi') {
                                      garasiIDSelected = '1';
                                    } else if (_title == 'Carport') {
                                      carportIDSelected = '1';
                                    } else if (_title == 'Legalitas') {
                                      legalityPage.legalityIDSelected = '1';
                                    }
                                    Get.back();
                                  });
                                }),
                            SimpleDialogOption(
                                child: Text('Tidak'),
                                onPressed: () {
                                  setState(() {
                                    _controller.text = 'Tidak';
                                    if (_title == 'Furniture') {
                                      furnitureIDSelected = '0';
                                    } else if (_title == 'Garasi') {
                                      garasiIDSelected = '0';
                                    } else if (_title == 'Carport') {
                                      carportIDSelected = '0';
                                    } else if (_title == 'Legalitas') {
                                      legalityPage.legalityIDSelected = '0';
                                    }
                                    Get.back();
                                  });
                                })
                          ]);
                        });
                  })),
          Icon(Icons.navigate_next, color: Colors.grey)
        ]));
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
                onTap: () => Get.to(_page, transition: Transition.rightToLeft)),
          ),
          Icon(Icons.navigate_next, color: Colors.grey)
        ]));
  }

  GestureDetector _uploadFoto(
      List<File> _imgFiles, List<String> _imgName, int _idx) {
    return GestureDetector(
        child: Center(
            child: Container(
                margin: EdgeInsets.only(right: 10),
                height: 180,
                width: 180,
                color: Colors.grey[200],
                child: Center(
                    child:
                        (_imgFiles.length > 0 && _idx.isLowerThan(imgBox - 1))
                            ? Image.file(_imgFiles[_idx])
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Icon(Icons.camera_alt,
                                        size: 40, color: Colors.grey),
                                    Text('Tambah foto',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 18))
                                  ])))),
        onLongPress: () async {
          if (_imgFiles.length > 0 && _imgFiles[_idx] != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(title: Text('Manage'), children: [
                    SimpleDialogOption(
                        child: Text('Hapus Foto'),
                        onPressed: () async {
                          Get.back();
                          EasyLoading.show(
                              status: 'Loading',
                              maskType: EasyLoadingMaskType.black);
                          _imgFiles.removeAt(_idx);

                          setState(() {
                            imgBox -= 1;
                          });
                          EasyLoading.dismiss();
                        })
                  ]);
                });
          }
        },
        onTap: () async {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(title: Text('Take image from'), children: [
                  SimpleDialogOption(
                      child: Text('Gallery'),
                      onPressed: () async {
                        Get.back();
                        EasyLoading.show(
                            status: 'Loading',
                            maskType: EasyLoadingMaskType.black);

                        PickedFile pickedFile = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          _imgFiles.add(File(pickedFile.path));
                          _imgName.add(base64Encode(
                              File(pickedFile.path).readAsBytesSync()));
                          setState(() {
                            imgBox += 1;
                          });
                        }
                        EasyLoading.dismiss();
                      }),
                  SimpleDialogOption(
                      child: Text('Camera'),
                      onPressed: () async {
                        Get.back();
                        EasyLoading.show(
                            status: 'Loading',
                            maskType: EasyLoadingMaskType.black);

                        PickedFile pickedFile = await ImagePicker().getImage(
                            source: ImageSource.camera, imageQuality: 10);
                        if (pickedFile != null) {
                          _imgFiles.add(File(pickedFile.path));
                          _imgName.add(base64Encode(
                              File(pickedFile.path).readAsBytesSync()));
                          setState(() {
                            imgBox += 1;
                          });
                        }
                        EasyLoading.dismiss();
                      })
                ]);
              });
        });
  }
}
