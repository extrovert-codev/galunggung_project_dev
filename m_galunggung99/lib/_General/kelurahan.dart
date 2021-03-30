import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/kelurahan_model.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/_General/kecamatan.dart' as kecamatanPage;

class Kelurahan extends StatefulWidget {
  @override
  _KelurahanState createState() => _KelurahanState();
}

String propAddressKelurahanIDSelected;
TextEditingController txtPropAddressKelurahan = TextEditingController();

String addressKelurahanIDSelected;
TextEditingController txtAddressKelurahan = TextEditingController();

String scheduleKelurahanIDSelected;
TextEditingController txtScheduleKelurahan = TextEditingController();

class _KelurahanState extends State<Kelurahan> {
  bool isLoading;

  List<dynamic> kelurahanID;
  List<dynamic> kelurahanName;

  Future refreshData() async {
    isLoading = true;
    kelurahanID = [];
    kelurahanName = [];

    String isKecamatan;
    if (provincePage.isPage == 'Property Address') {
      isKecamatan = kecamatanPage.propAddressKecamatanIDSelected;
    } else if (provincePage.isPage == 'Address') {
      isKecamatan = kecamatanPage.addressKecamatanIDSelected;
    } else if (provincePage.isPage == 'Schedule') {
      isKecamatan = kecamatanPage.scheduleKecamatanIDSelected;
    }
    KelurahanModel.execAPI(isKecamatan).then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            kelurahanID.add(value[i].kelurahanID);
            kelurahanName.add(value[i].name);
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
          title: Text('Kelurahan'),
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
                  itemCount: kelurahanID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(kelurahanName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              if (provincePage.isPage == 'Property Address')
                                (txtPropAddressKelurahan.text ==
                                        kelurahanName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Address')
                                (txtAddressKelurahan.text ==
                                        kelurahanName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Schedule')
                                (txtScheduleKelurahan.text ==
                                        kelurahanName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            if (provincePage.isPage == 'Property Address') {
                              propAddressKelurahanIDSelected =
                                  kelurahanID[i].toString();
                              txtPropAddressKelurahan.text =
                                  kelurahanName[i].toString();
                            } else if (provincePage.isPage == 'Address') {
                              addressKelurahanIDSelected =
                                  kelurahanID[i].toString();
                              txtAddressKelurahan.text =
                                  kelurahanName[i].toString();
                            } else if (provincePage.isPage == 'Schedule') {
                              scheduleKelurahanIDSelected =
                                  kelurahanID[i].toString();
                              txtScheduleKelurahan.text =
                                  kelurahanName[i].toString();
                            }
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
