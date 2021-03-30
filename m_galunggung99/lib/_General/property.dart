import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/property_model.dart';

class Property extends StatefulWidget {
  @override
  _PropertyState createState() => _PropertyState();
}

String propertyIDSelected;
TextEditingController txtProperty = TextEditingController();

class _PropertyState extends State<Property> {
  bool isLoading;
  List<dynamic> jenisPropertyID;
  List<dynamic> jenisPropertyName;

  Future refreshData() async {
    isLoading = true;
    jenisPropertyID = [];
    jenisPropertyName = [];

    PropertyModel.execAPI().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            jenisPropertyID.add(value[i].propertyID);
            jenisPropertyName.add(value[i].name);
          }
          isLoading = false;
        }
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
          title: Text('Jenis Property'),
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
                  itemCount: jenisPropertyID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(jenisPropertyName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              (txtProperty.text ==
                                      jenisPropertyName[i].toString())
                                  ? Icon(Icons.check_circle,
                                      color: Color.fromRGBO(44, 39, 59, 1))
                                  : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            propertyIDSelected = jenisPropertyID[i].toString();
                            txtProperty.text = jenisPropertyName[i].toString();
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
