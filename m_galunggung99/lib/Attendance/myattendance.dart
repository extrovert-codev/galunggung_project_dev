import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m_galunggung99/Attendance/Model/listattendance_model.dart';
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class MyAttendance extends StatefulWidget {
  @override
  _MyAttendanceState createState() => _MyAttendanceState();
}

class _MyAttendanceState extends State<MyAttendance> {
  DateTime valSDate, valEDate;

  List<dynamic> attID,
      txtName,
      image,
      txtAttRemarks,
      txtDate,
      txtTimeIn,
      txtTimeOut;
  Future refreshData() async {
    attID = [];
    txtName = [];
    image = [];
    txtAttRemarks = [];
    txtDate = [];
    txtTimeIn = [];
    txtTimeOut = [];

    ListAttendanceModel.execAPIPersonal(
            _gScript.myEmpID,
            DateFormat('yyyy-MM-dd').format(valSDate),
            DateFormat('yyyy-MM-dd').format(valEDate))
        .then((value) {
      setState(() {
        if (value != null) {
          attID = [];
          txtName = [];
          image = [];
          txtAttRemarks = [];
          txtDate = [];
          txtTimeIn = [];
          txtTimeOut = [];

          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              attID.add(value[i].attID);
              txtName.add(value[i].name);
              image.add(value[i].image);
              txtAttRemarks.add(value[i].attRemarks);
              txtDate.add(value[i].date);
              txtTimeIn.add(value[i].timeIn);
              txtTimeOut.add(value[i].timeOut);
            }
          }
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
            title: Text('Absenku', style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
                preferredSize: Size.square(50),
                child: Row(children: [
                  Expanded(child: _getDate(context, 'Dari', valSDate)),
                  Expanded(child: _getDate(context, 'Sampai', valEDate))
                ]))),
        body: Container(
            color: Colors.white,
            child: RefreshIndicator(
              onRefresh: () => refreshData(),
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: attID.length,
                  itemBuilder: (context, i) {
                    return _listData(i);
                  }),
            )));
  }

  Container _listData(int i) {
    return Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 13),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 3)
            ]),
        child: Row(children: [
          Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(left: 6),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: (image[i] != null)
                  ? Image.network(
                      'https://galunggung99.com/rest-api/galunggung-api/uploads/images/employee/' +
                          image[i])
                  : Icon(Icons.person)),
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(txtName[i],
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(DateTime.parse(txtDate[i])),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              )
                            ]),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('In : ' +
                                  txtTimeIn[i].toString().substring(0, 5)),
                              Text((txtTimeOut[i].toString() != null)
                                  ? 'Out : '
                                  : 'Out : ' +
                                      txtTimeOut[i].toString().substring(0, 5))
                            ])
                      ]))),
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: (txtAttRemarks[i] == 'P')
                      ? Colors.green
                      : (txtAttRemarks[i] == 'A')
                          ? Colors.red
                          : (txtAttRemarks[i] == 'L')
                              ? Colors.amber
                              : (txtAttRemarks[i] == 'O')
                                  ? Colors.blue
                                  : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Container(
                  child: Center(
                      child: Text(txtAttRemarks[i],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600)))))
        ]));
  }

  GestureDetector _getDate(BuildContext context, _label, _valDate) {
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 15),
            height: 50,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      (_valDate == null)
                          ? _label
                          : DateFormat('dd MMMM yyyy').format(_valDate),
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  Icon(Icons.date_range_outlined, color: Colors.amber)
                ])),
        onTap: () async {
          try {
            final DateTime picked = await showDatePicker(
                context: context,
                initialDate: (_valDate == null) ? DateTime.now() : _valDate,
                firstDate: (_label == 'Dari') ? DateTime(1945) : valSDate,
                lastDate: DateTime.now());
            if (picked != null && picked != _valDate)
              setState(() {
                if (_label == 'Dari') {
                  valSDate = picked;
                } else {
                  valEDate = picked;
                }

                if ((valSDate != null && valEDate != null) &&
                    (valEDate.isAtSameMomentAs(valSDate) ||
                        valEDate.isAfter(valSDate))) {
                  refreshData();
                } else {
                  SizedBox();
                }
              });
          } catch (e) {}
        });
  }
}
