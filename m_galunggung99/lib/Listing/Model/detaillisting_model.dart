import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_galunggung99/_GlobalScript.dart';

class DetailListingModel {
  String addressproperty,
      namepemilik,
      noktppemilik,
      alamatpemilik,
      phonepemilik,
      workpemilik;

  String namepelisting,
      noktppelisting,
      alamatpelisting,
      phonepelisting,
      workpelisting;

  String jenisproperty,
      alamatproperty,
      hargaproperty,
      isnego,
      lebarjalandepan,
      luastanah,
      luasbangunan,
      statuskunci,
      kamartidur,
      kamarmandi,
      kamarmandipembantu,
      ruangtamu,
      ruangmakan,
      ruangkeluarga,
      dapur,
      tamandepan,
      tamanbelakang,
      furniture,
      garasi,
      carport,
      legalitas,
      fclegalitas;

  DetailListingModel(
      {this.addressproperty,
      this.namepemilik,
      this.noktppemilik,
      this.alamatpemilik,
      this.phonepemilik,
      this.workpemilik,
      //
      this.namepelisting,
      this.noktppelisting,
      this.alamatpelisting,
      this.phonepelisting,
      this.workpelisting,
      //
      this.jenisproperty,
      this.alamatproperty,
      this.hargaproperty,
      this.isnego,
      this.lebarjalandepan,
      this.luastanah,
      this.luasbangunan,
      this.statuskunci,
      this.kamartidur,
      this.kamarmandi,
      this.kamarmandipembantu,
      this.ruangtamu,
      this.ruangmakan,
      this.ruangkeluarga,
      this.dapur,
      this.tamandepan,
      this.tamanbelakang,
      this.furniture,
      this.garasi,
      this.carport,
      this.legalitas,
      this.fclegalitas});

  factory DetailListingModel.getListing(Map<String, dynamic> object) {
    return DetailListingModel(
        addressproperty: object['addressproperty'],
        namepemilik: object['namepemilik'],
        noktppemilik: object['noktppemilik'],
        alamatpemilik: object['addresspemilik'],
        phonepemilik: object['phonepemilik'],
        workpemilik: object['workpemilik'],
        //
        namepelisting: object['name'],
        noktppelisting: object['noktp'],
        alamatpelisting: object['address'],
        phonepelisting: object['phone'],
        workpelisting: object['position'],
        //
        jenisproperty: object['property'],
        alamatproperty: object['addressproperty'],
        hargaproperty: object['price'],
        isnego: object['nego'],
        lebarjalandepan: object['lebarjalandepan'],
        luastanah: object['luastanah'],
        luasbangunan: object['luasbangunan'],
        statuskunci: object['statuskunci'],
        kamartidur: object['bedroom'],
        kamarmandi: object['bathroom'],
        kamarmandipembantu: object['maidbathroom'],
        ruangtamu: object['livingroom'],
        ruangmakan: object['dinningroom'],
        ruangkeluarga: object['familyroom'],
        dapur: object['kitchen'],
        tamandepan: object['tamandepan'],
        tamanbelakang: object['tamanbelakang'],
        furniture: object['furniture'],
        garasi: object['garage'],
        carport: object['carport'],
        legalitas: object['legality'],
        fclegalitas: object['fclegality']);
  }

  static Future<DetailListingModel> execAPI(listingID) async {
    var listingData;
    String apiURL = apiLink + '/Listing?listing_id=$listingID';
    var result = await http.get(apiURL, headers: {
      'Authorization': 'Basic ZVh0cm92ZXJ0Q29EZXY6bSFuIW00UDEyNw==',
      'xCdK3y5': 'P/Anp84aR046kFxcJolCn93b4UXNQ4moJ3DO6wqv'
    });
    if (result.statusCode == 200) {
      var jsonObject = jsonDecode(result.body);
      listingData = (jsonObject as Map<String, dynamic>)['data'];
      return DetailListingModel.getListing(listingData[0]);
    } else {
      return null;
    }
  }
}
