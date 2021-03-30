import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/Listing/detaillisting.dart' as detailListingPage;
import 'package:m_galunggung99/Profil/Model/listlistingsaya_model.dart';
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class ListListingTidakLengkapSaya extends StatefulWidget {
  @override
  _ListListingTidakLengkapSayaState createState() =>
      _ListListingTidakLengkapSayaState();
}

class _ListListingTidakLengkapSayaState
    extends State<ListListingTidakLengkapSaya> {
  bool isLoading;

  List<dynamic> listingID;
  List<String> addressProperty;
  List<dynamic> listingStatus;
  List<String> pemilikName;
  List<String> empName;
  List<String> empImage;
  List<dynamic> datePosted;

  Future refreshData() async {
    isLoading = true;
    listingID = [];
    addressProperty = [];
    listingStatus = [];
    pemilikName = [];
    empName = [];
    empImage = [];
    datePosted = [];

    ListListingSayaModel.execAPIGetListingAllEmp('1', _gScript.myEmpID)
        .then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            listingID.add(value[i].listingID);
            addressProperty.add(value[i].addressproperty);
            listingStatus.add(value[i].listingstatus);
            pemilikName.add(value[i].pemilikname);
            empName.add(value[i].empname);
            empImage.add(value[i].empimage);
            datePosted.add(value[i].dateposted);
          }
        }
      });
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (isLoading)
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: refreshData,
                child: Container(
                    color: Colors.grey[100],
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        itemCount: listingID.length,
                        itemBuilder: (context, i) {
                          return _listDataList(
                              listingID[i],
                              listingStatus[i],
                              pemilikName[i],
                              addressProperty[i],
                              datePosted[i],
                              empName[i],
                              empImage[i]);
                        }))));
  }

  Container _listDataList(_listingID, _listingStatus, _pemilikName,
      _alamatRumah, _tglPengajuan, _namaEmployee, _imageEmployee) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Stack(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(_listingStatus.toString().toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)))),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(_pemilikName, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 3),
                  Text(_tglPengajuan,
                      style: TextStyle(fontSize: 13, color: Colors.grey))
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                            Text(_alamatRumah,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey)),
                            SizedBox(height: 3),
                            Text(_namaEmployee,
                                style:
                                    TextStyle(fontSize: 13, color: Colors.blue))
                          ]))),
                      GestureDetector(
                          child: Row(children: [
                            Text('Lihat detail',
                                style: TextStyle(fontSize: 13)),
                            Icon(Icons.navigate_next)
                          ]),
                          onTap: () {
                            detailListingPage.listingID = _listingID;
                            Get.to(detailListingPage.DetailListing(),
                                transition: Transition.rightToLeft);
                          })
                    ])
              ]),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  height: 70,
                  width: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: (_imageEmployee == null)
                      ? Icon(Icons.person, size: 50)
                      : Image.network(
                          'https://galunggung99.com/rest-api/galunggung-api/uploads/images/employee/' +
                              _imageEmployee,
                          fit: BoxFit.contain)))
        ]));
  }
}
