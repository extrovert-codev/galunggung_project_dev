import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class ListListingSayaModel {
  String listingID,
      addressproperty,
      listingstatusID,
      listingstatus,
      pemilikname,
      empname,
      empimage,
      dateposted;

  ListListingSayaModel(
      {this.listingID,
      this.addressproperty,
      this.listingstatusID,
      this.listingstatus,
      this.pemilikname,
      this.empname,
      this.empimage,
      this.dateposted});

  factory ListListingSayaModel.getListing(Map<String, dynamic> object) {
    return ListListingSayaModel(
        listingID: object['listing_id'],
        addressproperty: object['addressproperty'],
        listingstatusID: object['listingstatus_id'],
        listingstatus: object['listingstatus'],
        pemilikname: object['namepemilik'],
        empname: object['name'],
        empimage: object['image'],
        dateposted: object['dateposted']);
  }

  static Future<List<ListListingSayaModel>> execAPIGetListingAllEmp(
      listingStatusID, empID) async {
    List<ListListingSayaModel> listing = [];
    String apiURL = apiLink +
        '/Listing?listingstatus_id=$listingStatusID&employee_id=$empID';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listListing = (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listListing.length; i++) {
        listing.add(ListListingSayaModel.getListing(listListing[i]));
      }
      return listing;
    } else {
      return null;
    }
  }
}
