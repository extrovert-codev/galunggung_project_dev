import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/activity_model.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

String activityIDSelected;
TextEditingController txtActivity = TextEditingController();

class _ActivityState extends State<Activity> {
  bool isLoading;
  List<dynamic> activityID;
  List<dynamic> activityName;

  Future refreshData() async {
    isLoading = true;
    activityID = [];
    activityName = [];

    ActivityModel.execAPI().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            activityID.add(value[i].activityID);
            activityName.add(value[i].name);
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
          title: Text('Kegiatan'),
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
                  itemCount: activityID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(activityName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              (txtActivity.text == activityName[i].toString())
                                  ? Icon(Icons.check_circle,
                                      color: Color.fromRGBO(44, 39, 59, 1))
                                  : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            activityIDSelected = activityID[i].toString();
                            txtActivity.text = activityName[i].toString();
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
