import 'package:flutter/material.dart';
import 'package:m_galunggung99/Listing/listlistingapproved.dart';
import 'package:m_galunggung99/Listing/listlistingcanceled.dart';
import 'package:m_galunggung99/Listing/listlistingpending.dart';
import 'package:m_galunggung99/Listing/listlistingtidaklengkap.dart';

class ListListingMenu extends StatefulWidget {
  @override
  _ListListingMenuState createState() => _ListListingMenuState();
}

class _ListListingMenuState extends State<ListListingMenu>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text('Daftar Listingan', style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            bottom: TabBar(
                labelColor: Colors.black,
                controller: tabController,
                indicatorColor: Colors.amber,
                labelPadding: EdgeInsets.symmetric(),
                tabs: [
                  Tab(text: 'Pending'),
                  Tab(text: 'Approved'),
                  Tab(text: 'Tidak Lengkap'),
                  Tab(text: 'Canceled')
                ]),
            elevation: 0),
        body: TabBarView(controller: tabController, children: [
          ListListingPending(),
          ListListingApproved(),
          ListListingTidakLengkap(),
          ListListingCanceled()
        ]));
  }
}
