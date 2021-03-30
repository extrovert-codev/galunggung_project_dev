import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/city_model.dart';
import 'package:m_galunggung99/_General/province.dart' as provincePage;

class City extends StatefulWidget {
  @override
  _CityState createState() => _CityState();
}

String pobCityIDSelected;
TextEditingController txtPobCity = TextEditingController();

String propAddressCityIDSelected;
TextEditingController txtPropAddressCity = TextEditingController();

String addressCityIDSelected;
TextEditingController txtAddressCity = TextEditingController();

String scheduleCityIDSelected;
TextEditingController txtScheduleCity = TextEditingController();

class _CityState extends State<City> {
  bool isLoading;
  List<dynamic> cityID;
  List<dynamic> cityName;

  Future refreshData() async {
    isLoading = true;
    cityID = [];
    cityName = [];

    String isProvince;
    if (provincePage.isPage == 'Place of Birth') {
      isProvince = provincePage.pobProvinceIDSelected;
    } else if (provincePage.isPage == 'Property Address') {
      isProvince = provincePage.propAddressProvinceIDSelected;
    } else if (provincePage.isPage == 'Address') {
      isProvince = provincePage.addressProvinceIDSelected;
    } else if (provincePage.isPage == 'Schedule') {
      isProvince = provincePage.scheduleProvinceIDSelected;
    }
    CityModel.execAPI(isProvince).then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            cityID.add(value[i].cityID);
            cityName.add(value[i].name);
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
          title: Text('Kota/Kabupaten'),
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
                  itemCount: cityID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(cityName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              if (provincePage.isPage == 'Place of Birth')
                                (txtPobCity.text == cityName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Property Address')
                                (txtPropAddressCity.text ==
                                        cityName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Address')
                                (txtAddressCity.text == cityName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (provincePage.isPage == 'Schedule')
                                (txtScheduleCity.text == cityName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            if (provincePage.isPage == 'Place of Birth') {
                              pobCityIDSelected = cityID[i].toString();
                              txtPobCity.text = cityName[i].toString();
                            } else if (provincePage.isPage ==
                                'Property Address') {
                              propAddressCityIDSelected = cityID[i].toString();
                              txtPropAddressCity.text = cityName[i].toString();
                            } else if (provincePage.isPage == 'Address') {
                              addressCityIDSelected = cityID[i].toString();
                              txtAddressCity.text = cityName[i].toString();
                            } else if (provincePage.isPage == 'Schedule') {
                              scheduleCityIDSelected = cityID[i].toString();
                              txtScheduleCity.text = cityName[i].toString();
                            }
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
