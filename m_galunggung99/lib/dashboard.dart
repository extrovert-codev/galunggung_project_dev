import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_galunggung99/Attendance/myattendance.dart';
import 'package:m_galunggung99/_GlobalScript.dart';
import 'package:m_galunggung99/Home/homedirut.dart';
import 'package:m_galunggung99/Listing/inputlisting.dart';
import 'package:m_galunggung99/Schedule/listschedule.dart';
import 'package:m_galunggung99/Home/homemarketing.dart';
import 'package:m_galunggung99/Home/homeoprasional.dart';
import 'package:m_galunggung99/Profil/profil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'Listing/approvelisting.dart';
import 'Listing/listlistingmenu.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int navSelectedIndex = 2;

  List pageList = [
    ListSchedule(),
    MyAttendance(),
    (myPositionID == '1' || myPositionID == '9')
        ? HomeDirut()
        : (myPositionID == '2' || myPositionID == '5' || myPositionID == '6')
            ? HomeMarketing()
            : (myPositionID == '3' || myPositionID == '4')
                ? HomeOprasional()
                : SizedBox(),
    InputListing(),
    Profil()
  ];

  @override
  void initState() {
    // TODO: implement initState
    onesignal();
    super.initState();
  }

  Future<void> onesignal() async {
    var c;
    OneSignal.shared.setLogLevel(OSLogLevel.error, OSLogLevel.none);

    OneSignal.shared.init(
        "537a5c52-cc1c-47ea-9931-425eb7f8f205",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
      print("onSetNotificationReceive");
      c = notification.payload.additionalData;
      print(c);
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
      print("onSetNotificationOpen");

      if(c['type'] == "get_approve"){
        print('here');
        Get.to(ApproveListing());
      }else if(c['type'].toString() == "approved"){
        Get.to(ListListingMenu());
      }else{
        print(c['type']);
      }
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // will be called whenever the subscription changes
      //(ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });

// For each of the above functions, you can also pass in a
// reference to a function as well:

    void _handleNotificationReceived(OSNotification notification) {

    }

    void main() {
      OneSignal.shared.setNotificationReceivedHandler(_handleNotificationReceived);
    }

    OneSignal.shared.promptUserForPushNotificationPermission();

// If you want to know if the user allowed/denied permission,
// the function returns a Future<bool>:
    bool allowed = await OneSignal.shared.promptUserForPushNotificationPermission();
    OneSignal.shared.setExternalUserId(myEmpID);
    // print(allowed);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: pageList.elementAt(navSelectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: Colors.amber),
            currentIndex: navSelectedIndex,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color.fromRGBO(44, 39, 59, 1),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart_outlined), label: 'Kegiatan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fingerprint), label: 'Absensi'),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_work_outlined), label: 'Listing'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined), label: 'Saya')
            ],
            onTap: (value) {
              setState(() {
                navSelectedIndex = value;
              });
            }));
  }
}
