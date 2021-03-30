import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/statuskunci_model.dart';

class StatusKunci extends StatefulWidget {
  @override
  _StatusKunciState createState() => _StatusKunciState();
}

String statusKunciIDSelected;
TextEditingController txtStatusKunci = TextEditingController();

class _StatusKunciState extends State<StatusKunci> {
  bool isLoading;
  List<dynamic> statuskunciID;
  List<dynamic> statuskunciName;

  Future refreshData() async {
    isLoading = true;
    statuskunciID = [];
    statuskunciName = [];

    StatusKunciModel.execAPI().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            statuskunciID.add(value[i].statusKunciID);
            statuskunciName.add(value[i].name);
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
          title: Text('Status Kunci'),
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
                  itemCount: statuskunciID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(statuskunciName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              (txtStatusKunci.text ==
                                      statuskunciName[i].toString())
                                  ? Icon(Icons.check_circle,
                                      color: Color.fromRGBO(44, 39, 59, 1))
                                  : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            statusKunciIDSelected = statuskunciID[i].toString();
                            txtStatusKunci.text = statuskunciName[i].toString();
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
