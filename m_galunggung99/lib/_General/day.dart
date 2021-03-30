import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/day_model.dart';

class Day extends StatefulWidget {
  @override
  _DayState createState() => _DayState();
}

String dayIDSelected;
TextEditingController txtDay = TextEditingController();

class _DayState extends State<Day> {
  bool isLoading;
  List<dynamic> dayID;
  List<dynamic> dayName;

  Future refreshData() async {
    isLoading = true;
    dayID = [];
    dayName = [];

    DayModel.execAPI().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            dayID.add(value[i].dayID);
            dayName.add(value[i].name);
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
          title: Text('Day'),
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
                  itemCount: dayID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(dayName[i].toString(),
                                      style: TextStyle(fontSize: 14))),
                              (txtDay.text == dayName[i].toString())
                                  ? Icon(Icons.check_circle,
                                      color: Color.fromRGBO(44, 39, 59, 1))
                                  : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            dayIDSelected = dayID[i].toString();
                            txtDay.text = dayName[i].toString();
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
