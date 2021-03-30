import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart' as _gScript;

class ListingImageModel {
  String employeeID, imagename, image, iscover, remarks, useredited;

  ListingImageModel(
      {this.employeeID,
      this.imagename,
      this.image,
      this.iscover,
      this.remarks,
      this.useredited});

  factory ListingImageModel.listingImage(Map<String, dynamic> object) {
    return ListingImageModel(
        employeeID: object['employee_id'],
        imagename: object['imagename'],
        image: object['image'],
        iscover: object['iscover'],
        remarks: object['remarks'],
        useredited: object['useredited']);
  }

  static Future<ListingImageModel> execAPIPostListingImage(
      String employeeID,
      String imagename,
      String image,
      String iscover,
      String remarks,
      String useredited) async {
    String apiURL = _gScript.apiLink + '/ListingImage';

    var result = await http.post(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    }, body: {
      'employee_id': employeeID,
      'imagename': imagename,
      'image': image,
      'iscover': iscover,
      'remarks': remarks,
      'useredited': useredited
    });

    var jsonObject = jsonDecode(result.body);
    return ListingImageModel.listingImage(jsonObject);
  }

  static Future<List<ListingImageModel>> execAPIGetListingImage(
      String listingID) async {
    List<ListingImageModel> listingImage = [];
    String apiURL = _gScript.apiLink + '/ListingImage?listing_id=$listingID';

    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      List<dynamic> listListingImage =
          (jsonObject as Map<String, dynamic>)['data'];

      for (int i = 0; i < listListingImage.length; i++) {
        listingImage.add(ListingImageModel.listingImage(listListingImage[i]));
      }
      return listingImage;
    } else {
      return null;
    }
  }
}
