import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/province_model.dart';

class Province extends StatefulWidget {
  @override
  _ProvinceState createState() => _ProvinceState();
}

String isPage = '';

String pobProvinceIDSelected;
TextEditingController txtPobProvince = TextEditingController();

String propAddressProvinceIDSelected;
TextEditingController txtPropAddressProvince = TextEditingController();

String addressProvinceIDSelected;
TextEditingController txtAddressProvince = TextEditingController();

String scheduleProvinceIDSelected;
TextEditingController txtScheduleProvince = TextEditingController();

class _ProvinceState extends State<Province> {
  bool isLoading;
  List<dynamic> provinceID;
  List<dynamic> provinceName;

  Future refreshData() async {
    isLoading = true;
    provinceID = [];
    provinceName = [];

    ProvinceModel.execAPI().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            provinceID.add(value[i].provinceID);
            provinceName.add(value[i].name);
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
          title: Text('Provinsi'),
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
                  itemCount: provinceID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(provinceName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              if (isPage == 'Place of Birth')
                                (txtPobProvince.text ==
                                        provinceName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (isPage == 'Property Address')
                                (txtPropAddressProvince.text ==
                                        provinceName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (isPage == 'Address')
                                (txtAddressProvince.text ==
                                        provinceName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (isPage == 'Schedule')
                                (txtScheduleProvince.text ==
                                        provinceName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            if (isPage == 'Place of Birth') {
                              pobProvinceIDSelected = provinceID[i].toString();
                              txtPobProvince.text = provinceName[i].toString();
                            } else if (isPage == 'Property Address') {
                              propAddressProvinceIDSelected =
                                  provinceID[i].toString();
                              txtPropAddressProvince.text =
                                  provinceName[i].toString();
                            } else if (isPage == 'Address') {
                              addressProvinceIDSelected =
                                  provinceID[i].toString();
                              txtAddressProvince.text =
                                  provinceName[i].toString();
                            } else if (isPage == 'Schedule') {
                              scheduleProvinceIDSelected =
                                  provinceID[i].toString();
                              txtScheduleProvince.text =
                                  provinceName[i].toString();
                            }
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
