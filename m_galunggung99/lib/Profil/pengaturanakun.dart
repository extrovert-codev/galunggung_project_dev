import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:m_galunggung99/Profil/Model/pengaturanakun_model.dart';
import 'package:m_galunggung99/Profil/Model/pengaturanakunimage_model.dart';
import 'package:m_galunggung99/_General/placeofbirth.dart' as placeofbirthPage;
import 'package:m_galunggung99/_General/address.dart' as addressPage;
import 'package:m_galunggung99/_General/position.dart' as positionPage;
import 'package:m_galunggung99/_GlobalProcedureFunction.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class PengaturanAkun extends StatefulWidget {
  @override
  _PengaturanAkunState createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  bool isLoading;
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtNoKTP = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  File image;
  String myDOB, base64Image;
  DateTime valDOB;

  Future refreshData() async {
    isLoading = true;
    setState(() {
      valDOB = null;
      txtFirstName.text = '';
      txtLastName.text = '';
      txtNoKTP.text = '';
      txtPhone.text = '';
      txtPassword.text = '';
      txtConfirmPassword.text = '';
      image = null;
      base64Image = '';
      isLoading = false;
      myDOB = 'Tanggal Lahir';
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
            title: Text('Registrasi', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0),
        body: (isLoading)
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Colors.white,
                child: RefreshIndicator(
                    onRefresh: () => refreshData(),
                    child: ListView(
                        padding: EdgeInsets.only(bottom: 10),
                        children: [
                          Container(
                              height: 200,
                              child: Center(
                                  child: GestureDetector(
                                      child: Container(
                                          padding: EdgeInsets.all(3),
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: Colors.green[300]),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: (image == null)
                                              ? Icon(Icons.camera_alt,
                                                  size: 50,
                                                  color: Colors.grey[400])
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.file(image,
                                                      fit: BoxFit.cover))),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                  title:
                                                      Text('Take image from'),
                                                  children: [
                                                    SimpleDialogOption(
                                                        child: Text('Gallery'),
                                                        onPressed: () async {
                                                          Get.back();
                                                          EasyLoading.show(
                                                              status: 'Loading',
                                                              maskType:
                                                                  EasyLoadingMaskType
                                                                      .black);

                                                          PickedFile
                                                              pickedFile =
                                                              await ImagePicker()
                                                                  .getImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                          if (pickedFile !=
                                                              null) {
                                                            setState(() {
                                                              image = File(
                                                                  pickedFile
                                                                      .path);
                                                              base64Image = base64Encode(File(
                                                                      pickedFile
                                                                          .path)
                                                                  .readAsBytesSync());
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
                                                              maskType:
                                                                  EasyLoadingMaskType
                                                                      .black);

                                                          PickedFile
                                                              pickedFile =
                                                              await ImagePicker().getImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera,
                                                                  imageQuality:
                                                                      10);
                                                          if (pickedFile !=
                                                              null) {
                                                            setState(() {
                                                              image = File(
                                                                  pickedFile
                                                                      .path);
                                                              base64Image = base64Encode(File(
                                                                      pickedFile
                                                                          .path)
                                                                  .readAsBytesSync());
                                                            });
                                                          }
                                                          EasyLoading.dismiss();
                                                        })
                                                  ]);
                                            });
                                      }))),
                          _textField(txtFirstName, false, 'Nama Depan',
                              TextInputType.name, TextInputAction.next),
                          Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Divider(height: 1, thickness: 1)),
                          _textField(txtLastName, false, 'Nama Belakang',
                              TextInputType.name, TextInputAction.next),
                          Container(color: Colors.grey[100], height: 7),
                          _selector(addressPage.txtAddress, 'Tempat Tinggal',
                              addressPage.Address()),
                          Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Divider(height: 1, thickness: 1)),
                          _selector(placeofbirthPage.txtPlaceOfBirth,
                              'Tempat Lahir', placeofbirthPage.PlaceOfBirth()),
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
                                  (valDOB == null)
                                      ? myDOB
                                      : DateFormat('dd MMMM yyyy')
                                          .format(valDOB),
                                  style: TextStyle(
                                      color: (valDOB == null)
                                          ? Colors.grey
                                          : Colors.black,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            onTap: () => _selectDate(context),
                          ),
                          Container(color: Colors.grey[100], height: 7),
                          _textField(txtNoKTP, false, 'No KTP',
                              TextInputType.text, TextInputAction.next),
                          Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Divider(height: 1, thickness: 1)),
                          _selector(positionPage.txtPosition, 'Posisi',
                              positionPage.Position()),
                          Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Divider(height: 1, thickness: 1)),
                          _textField(txtPhone, false, 'No HP/WhatsApp',
                              TextInputType.phone, TextInputAction.next),
                          Container(color: Colors.grey[100], height: 7),
                          _textField(txtPassword, true, 'Password',
                              TextInputType.text, TextInputAction.next),
                          Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Divider(height: 1, thickness: 1)),
                          _textField(
                              txtConfirmPassword,
                              true,
                              'Konfirmasi Password',
                              TextInputType.text,
                              TextInputAction.done),
                          Container(color: Colors.grey[100], height: 7),
                          Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              height: 60,
                              child: Center(
                                  child: GestureDetector(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(44, 39, 59, 1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text('Daftar',
                                                  style: TextStyle(
                                                      color: Colors.white)))),
                                      onTap: () {
                                        if (txtFirstName.text == '' ||
                                            txtLastName.text == '' ||
                                            txtNoKTP.text == '' ||
                                            txtPhone.text == '' ||
                                            txtPassword.text == '' ||
                                            txtConfirmPassword.text == '') {
                                          Alert(
                                              context: context,
                                              type: AlertType.error,
                                              title: 'Opss..',
                                              content:
                                                  Text('Harap lengkapi data!'),
                                              buttons: [
                                                DialogButton(
                                                    color: Color.fromRGBO(
                                                        44, 39, 59, 1),
                                                    child: Text('OK',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    onPressed: () => Get.back())
                                              ]).show();
                                        } else {
                                          if (txtPassword.text !=
                                              txtConfirmPassword.text) {
                                            Alert(
                                                context: context,
                                                type: AlertType.error,
                                                title: 'Opss..',
                                                content: Text(
                                                    'Password tidak sesuai!'),
                                                buttons: [
                                                  DialogButton(
                                                      color: Color.fromRGBO(
                                                          44, 39, 59, 1),
                                                      child: Text('OK',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      onPressed: () =>
                                                          Get.back())
                                                ]).show().then(
                                                (value) => setState(() {
                                                      txtConfirmPassword.text =
                                                          '';
                                                    }));
                                          } else {
                                            FocusScope.of(context).unfocus();
                                            EasyLoading.show(
                                                status: 'Loading',
                                                maskType:
                                                    EasyLoadingMaskType.black);
                                            PengaturanAkunModel.execAPIPut(
                                                    _gScript.myEmpID,
                                                    txtFirstName.text,
                                                    txtLastName.text,
                                                    addressPage.txtAddress.text,
                                                    placeofbirthPage
                                                        .txtPlaceOfBirth.text,
                                                    valDOB.toString(),
                                                    txtNoKTP.text,
                                                    positionPage
                                                        .positionIDSelected,
                                                    txtPhone.text,
                                                    antiHack(txtPassword.text)
                                                        .toString())
                                                .then((value) {
                                              EasyLoading.dismiss();
                                              String fileName =
                                                  image.path.split('/').last;
                                              PengaturanAkunImageModel
                                                  .execAPIPut(_gScript.myEmpID,
                                                      fileName, base64Image);
                                              Alert(
                                                  context: context,
                                                  title: 'Horee..',
                                                  desc:
                                                      'Pendaftaran berhasil! :)',
                                                  type: AlertType.success,
                                                  buttons: [
                                                    DialogButton(
                                                        color: Color.fromARGB(
                                                            255, 15, 193, 167),
                                                        child: Text('OK',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        onPressed: () {
                                                          setState(() {
                                                            refreshData();
                                                          });
                                                        })
                                                  ]).show();
                                            });
                                          }
                                        }
                                      })))
                        ]))));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: (valDOB == null) ? DateTime.now() : valDOB,
        firstDate: DateTime(1945),
        lastDate: DateTime(2100));
    if (picked != null && picked != valDOB)
      setState(() {
        valDOB = picked;
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

  Container _textField(
      TextEditingController _controller,
      bool _isPassword,
      String _textLabel,
      TextInputType _textInputType,
      TextInputAction _textInputAction) {
    return Container(
        padding: EdgeInsets.only(left: 12, right: 10),
        color: Colors.white,
        child: TextField(
            controller: _controller,
            obscureText: _isPassword,
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
