import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/_General/Model/legality_model.dart';

class Legality extends StatefulWidget {
  final String legalityType;
  Legality({Key key, @required this.legalityType}) : super(key: key);
  @override
  _LegalityState createState() => _LegalityState();
}

String legalityIDSelected;
TextEditingController txtLegality = TextEditingController();
String fcLegalityIDSelected;
TextEditingController txtFCLegality = TextEditingController();

class _LegalityState extends State<Legality> {
  bool isLoading;
  List<dynamic> legalitasID;
  List<dynamic> legalitasName;

  Future refreshData() async {
    isLoading = true;
    legalitasID = [];
    legalitasName = [];

    LegalityModel.execAPI().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            legalitasID.add(value[i].legalityID);
            legalitasName.add(value[i].name);
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
          title: Text(widget.legalityType),
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
                  itemCount: legalitasID.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 12, right: 10),
                            color: Colors.white,
                            child: Row(children: [
                              Expanded(
                                  child: Text(legalitasName[i].toString(),
                                      style: TextStyle(fontSize: 12))),
                              if (widget.legalityType == 'Legalitas')
                                (txtLegality.text ==
                                        legalitasName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null),
                              if (widget.legalityType == 'Foto Copy Legalitas')
                                (txtFCLegality.text ==
                                        legalitasName[i].toString())
                                    ? Icon(Icons.check_circle,
                                        color: Color.fromRGBO(44, 39, 59, 1))
                                    : Icon(null)
                            ])),
                        onTap: () {
                          setState(() {
                            if (widget.legalityType == 'Legalitas') {
                              legalityIDSelected = legalitasID[i].toString();
                              txtLegality.text = legalitasName[i].toString();
                            } else if (widget.legalityType ==
                                'Foto Copy Legalitas') {
                              fcLegalityIDSelected = legalitasID[i].toString();
                              txtFCLegality.text = legalitasName[i].toString();
                            }
                            Get.back();
                          });
                        });
                  })),
    );
  }
}
