import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/Listing/inputlisting.dart';
import 'package:m_galunggung99/Profil/listlistingapprovedsaya.dart';
import 'package:m_galunggung99/Profil/listlistingcanceledsaya.dart';
import 'package:m_galunggung99/Profil/listlistingpendingsaya.dart';
import 'package:m_galunggung99/Profil/listlistingtidaklengkapsaya.dart';

class ListListingMenuSaya extends StatefulWidget {
  @override
  _ListListingMenuSayaState createState() => _ListListingMenuSayaState();
}

class _ListListingMenuSayaState extends State<ListListingMenuSaya>
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
          title: Text('Daftar Listingan Saya',
              style: TextStyle(color: Colors.black)),
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
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.add), onPressed: () => Get.to(InputListing()))
          ],
        ),
        body: TabBarView(controller: tabController, children: [
          ListListingPendingSaya(),
          ListListingApprovedSaya(),
          ListListingTidakLengkapSaya(),
          ListListingCanceledSaya()
        ]));
  }
}
