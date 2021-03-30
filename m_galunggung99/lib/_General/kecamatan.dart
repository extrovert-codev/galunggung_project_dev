import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/kecamatan_model.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;
import 'package:m_galunggung99/_General/city.dart' as cityPage;

class Kecamatan extends StatefulWidget {
  @override
  _KecamatanState createState() => _KecamatanState();
}

String propAddressKecamatanIDSelected;
TextEditingController txtPropAddressKecamatan = TextEditingController();

String addressKecamatanIDSelected;
TextEditingController txtAddressKecamatan = TextEditingController();

String scheduleKecamatanIDSelected;
TextEditingController txtScheduleKecamatan = TextEditingController();

class _KecamatanState extends State<Kecamatan> {
  bool isLoading;

  List<dynamic> kecamatanID;
  List<dynamic> kecamatanName;

  Future refreshData() async {
    isLoading = true;
    kecamatanID = [];
    kecamatanName = [];

    String isCity;
    if (provincePage.isPage == 'Property Address') {
      isCity = cityPage.propAddressCityIDSelected;
    } else if (provincePage.isPage == 'Address') {
      isCity = cityPage.addressCityIDSelected;
    } else if (provincePage.isPage == 'Schedule') {
      isCity = cityPage.scheduleCityIDSelected;
    }
    KecamatanModel.execAPI(isCity).then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            kecamatanID.add(value[i].kecamatanID);
            kecamatanName.add(value[i].name);
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
          title: Text('Kecamatan'),
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
                  itemCount: kecamatanID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(kecamatanName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              if (provincePage.isPage == 'Property Address')
                                (txtPropAddressKecamatan.text ==
                                        kecamatanName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Address')
                                (txtAddressKecamatan.text ==
                                        kecamatanName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Schedule')
                                (txtScheduleKecamatan.text ==
                                        kecamatanName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            if (provincePage.isPage == 'Property Address') {
                              propAddressKecamatanIDSelected =
                                  kecamatanID[i].toString();
                              txtPropAddressKecamatan.text =
                                  kecamatanName[i].toString();
                            } else if (provincePage.isPage == 'Address') {
                              addressKecamatanIDSelected =
                                  kecamatanID[i].toString();
                              txtAddressKecamatan.text =
                                  kecamatanName[i].toString();
                            } else if (provincePage.isPage == 'Schedule') {
                              scheduleKecamatanIDSelected =
                                  kecamatanID[i].toString();
                              txtScheduleKecamatan.text =
                                  kecamatanName[i].toString();
                            }
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
