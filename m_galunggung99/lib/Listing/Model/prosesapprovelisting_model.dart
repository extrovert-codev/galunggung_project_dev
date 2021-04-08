import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class ProsesApproveListingModel {
  String listingID, listingStatusID;

  ProsesApproveListingModel({this.listingID, this.listingStatusID});

  factory ProsesApproveListingModel.putProsesApproveListing(
      Map<String, dynamic> object) {
    return ProsesApproveListingModel(
        listingID: object['listing_id'],
        listingStatusID: object['listingstatus_id']);
  }

  static Future<ProsesApproveListingModel> execAPIPut(
      listingID, listingStatusID) async {
    (myPositionID == '1' || myPositionID == '9')
        ? listingStatusID = 4
        : (myPositionID == '11')
        ? listingStatusID = listingStatusID : listingStatusID = 0;
    String apiURL = apiLink + '/Listing';
    var result = await http.put(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    }, body: {
      'listing_id': listingID,
      'listingstatus_id': listingStatusID
    });
    var jsonObject = jsonDecode(result.body);

    return ProsesApproveListingModel.putProsesApproveListing(jsonObject);
  }
}
