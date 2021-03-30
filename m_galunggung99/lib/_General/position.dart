import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/position_model.dart';

class Position extends StatefulWidget {
  @override
  _PositionState createState() => _PositionState();
}

String positionIDSelected;
TextEditingController txtPosition = TextEditingController();

class _PositionState extends State<Position> {
  bool isLoading;

  List<dynamic> positionID;
  List<dynamic> positionName;

  Future refreshData() async {
    isLoading = true;
    positionID = [];
    positionName = [];

    PositionModel.execAPI().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            positionID.add(value[i].positionID);
            positionName.add(value[i].name);
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
          title: Text('Posisi'),
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
                  itemCount: positionID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(positionName[i].toString(),
                                      style: TextStyle(fontSize: 14))),
                              (txtPosition.text == positionName[i].toString())
                                  ? Icon(Icons.check_circle,
                                      color: Color.fromRGBO(44, 39, 59, 1))
                                  : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            positionIDSelected = positionID[i].toString();
                            txtPosition.text = positionName[i].toString();
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
