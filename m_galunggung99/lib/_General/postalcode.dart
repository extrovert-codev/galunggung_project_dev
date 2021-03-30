import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/postalcode_model.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/_General/kelurahan.dart' as kelurahanPage;

class PostalCode extends StatefulWidget {
  @override
  _PostalCodeState createState() => _PostalCodeState();
}

String propAddressPostalCodeIDSelected;
TextEditingController txtPropAddressPostalCode = TextEditingController();

String addressPostalCodeIDSelected;
TextEditingController txtAddressPostalCode = TextEditingController();

String schedulePostalCodeIDSelected;
TextEditingController txtSchedulePostalCode = TextEditingController();

class _PostalCodeState extends State<PostalCode> {
  bool isLoading;
  List<dynamic> postalCodeID;
  List<dynamic> postalCodeName;

  Future refreshData() async {
    isLoading = true;
    postalCodeID = [];
    postalCodeName = [];

    String isKelurahan;
    if (provincePage.isPage == 'Property Address') {
      isKelurahan = kelurahanPage.propAddressKelurahanIDSelected;
    } else if (provincePage.isPage == 'Address') {
      isKelurahan = kelurahanPage.addressKelurahanIDSelected;
    } else if (provincePage.isPage == 'Schedule') {
      isKelurahan = kelurahanPage.scheduleKelurahanIDSelected;
    }

    PostalCodeModel.execAPI(isKelurahan).then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            postalCodeID.add(value[i].postalCodeID);
            postalCodeName.add(value[i].name);
          }
        }
        isLoading = false;
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
          title: Text('Kode Pos'),
          backgroundColor: Color.fromRGBO(44, 39, 59, 1),
          elevation: 0),
      body: (isLoading)
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: ListView.separated(
                  separatorBuilder: (context, i) => Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Divider(height: 1, thickness: 1)),
                  itemCount: postalCodeID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(postalCodeName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              if (provincePage.isPage == 'Property Address')
                                (txtPropAddressPostalCode.text ==
                                        postalCodeName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Address')
                                (txtAddressPostalCode.text ==
                                        postalCodeName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Schedule')
                                (txtSchedulePostalCode.text ==
                                        postalCodeName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            if (provincePage.isPage == 'Property Address') {
                              propAddressPostalCodeIDSelected =
                                  postalCodeID[i].toString();
                              txtPropAddressPostalCode.text =
                                  postalCodeName[i].toString();
                            } else if (provincePage.isPage == 'Address') {
                              addressPostalCodeIDSelected =
                                  postalCodeID[i].toString();
                              txtAddressPostalCode.text =
                                  postalCodeName[i].toString();
                            } else if (provincePage.isPage == 'Schedule') {
                              schedulePostalCodeIDSelected =
                                  postalCodeID[i].toString();
                              txtSchedulePostalCode.text =
                                  postalCodeName[i].toString();
                            }
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
