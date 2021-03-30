import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:m_galunggung99/Listing/Model/detaillisting_model.dart';
import 'package:m_galunggung99/Listing/Model/listingimage_model.dart';

class DetailListing extends StatefulWidget {
  @override
  _DetailListingState createState() => _DetailListingState();
}

String listingID;

class _DetailListingState extends State<DetailListing> {
  bool isLoading;

  String txtAddressProperty = '';
  String txtNamePemilik = '';
  String txtNoKTPPemilik = '';
  String txtAddressPemilik = '';
  String txtPhonePemilik = '';
  String txtWorkPemilik = '';

  String txtNamePelisting = '';
  String txtNoKTPPelisting = '';
  String txtAddressPelisting = '';
  String txtPhonePelisting = '';
  String txtWorkPelisting = '';

  String txtJenisProperty = '';
  String txtAlamatProperty = '';
  String txtHargaProperty = '';
  String isNego = '';
  String txtLebarJalanDepan = '';
  String txtLuasTanah = '';
  String txtLuasBangunan = '';
  String txtStatusKunci = '';
  String txtKamarTidur = '';
  String txtKamarMandi = '';
  String txtKamarMandiPembantu = '';
  String txtRuangTamu = '';
  String txtRuangMakan = '';
  String txtRuangKeluarga = '';
  String txtDapur = '';
  String txtTamanDepan = '';
  String txtTamanBelakang = '';
  String txtFurniture = '';
  String txtGarasi = '';
  String txtCarport = '';
  String txtLegalitas = '';
  String txtFCLegalitas = '';

  List<String> imgList;

  DetailListingModel detailListingModel;

  Future refreshData() async {
    isLoading = true;
    imgList = [];
    ListingImageModel.execAPIGetListingImage(listingID).then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            imgList.add(value[i].imagename);
          }
        }
      });
    });

    DetailListingModel.execAPI(listingID).then((value) {
      detailListingModel = value;
      if (detailListingModel != null) {
        setState(() {
          txtAddressProperty = value.addressproperty;
          txtNamePemilik = value.namepemilik;
          txtNoKTPPemilik = value.noktppemilik;
          txtAddressPemilik = value.alamatpemilik;
          txtPhonePemilik = value.phonepemilik;
          txtWorkPemilik = value.workpemilik;

          txtNamePelisting = value.namepelisting;
          txtNoKTPPelisting = value.noktppelisting;
          txtAddressPelisting = value.alamatpelisting;
          txtPhonePelisting = value.phonepelisting;
          txtWorkPelisting = value.workpelisting;

          txtJenisProperty = value.jenisproperty;
          txtAlamatProperty = value.alamatproperty;
          txtHargaProperty = value.hargaproperty;
          isNego = value.isnego;
          txtLebarJalanDepan = value.lebarjalandepan;
          txtLuasTanah = value.luastanah;
          txtLuasBangunan = value.luasbangunan;
          txtStatusKunci = value.statuskunci;
          txtKamarTidur = value.kamartidur;
          txtKamarMandi = value.kamarmandi;
          txtKamarMandiPembantu = value.kamarmandipembantu;
          txtRuangTamu = value.ruangtamu;
          txtRuangMakan = value.ruangmakan;
          txtRuangKeluarga = value.ruangkeluarga;
          txtDapur = value.dapur;
          txtTamanDepan = value.tamandepan;
          txtTamanBelakang = value.tamanbelakang;
          txtFurniture = value.furniture;
          txtGarasi = value.garasi;
          txtCarport = value.carport;
          txtLegalitas = value.legalitas;
          txtFCLegalitas = value.fclegalitas;

          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Detail Listing'),
            backgroundColor: Color.fromRGBO(44, 39, 59, 1),
            elevation: 0),
        body: (isLoading)
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Colors.white,
                child: ListView(children: [
                  (imgList.length == 0)
                      ? Container(
                          height: 450,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image_not_supported,
                                    color: Colors.grey[400], size: 50),
                                Text('No Image',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                        color: Colors.grey[400]))
                              ]))
                      : CarouselSlider(
                          options: CarouselOptions(
                              height: 450, enlargeCenterPage: true),
                          items: imgList.map((imgURL) {
                            return Container(
                                child: Image.network(
                                    'https://galunggung99.com/rest-api/galunggung-api/uploads/images/listing/' +
                                        imgURL));
                          }).toList()),
                  Container(color: Colors.grey[100], height: 7),
                  //-- Deskripsi
                  Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Deskripsi',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 15),
                            Text('Lokasi',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            SizedBox(height: 15),
                            Text(txtAddressProperty),
                            SizedBox(height: 20),
                            Row(children: [
                              Text('Biodata Pemilik',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600))
                            ]),
                            SizedBox(height: 15),
                            _content('Nama', txtNamePemilik),
                            _content('No KTP', txtNoKTPPemilik),
                            _content('Alamat', txtAddressPemilik),
                            _content('Kontak', txtPhonePemilik),
                            _content('Pekerjaan', txtWorkPemilik),
                            SizedBox(height: 20),

                            //--
                            Row(children: [
                              Text('Biodata Pelisting',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600))
                            ]),
                            SizedBox(height: 15),
                            _content('Nama', txtNamePelisting),
                            _content('No KTP', txtNoKTPPelisting),
                            _content('Alamat', txtAddressPelisting),
                            _content('Kontak', txtPhonePelisting),
                            _content('Pekerjaan', txtWorkPelisting),
                          ])),
                  Container(color: Colors.grey[100], height: 7),
                  //-- Deskripsi

                  //-- Fasilitas
                  Container(
                      padding: EdgeInsets.all(15),
                      color: Colors.white,
                      child: Column(children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Detail',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(height: 15),
                        _content('Jenis Property', txtJenisProperty),
                        _content('Alamat Property', txtAlamatProperty),
                        _content('Harga Property (Rp.)',
                            'Rp. $txtHargaProperty $isNego'),
                        _content('Lebar Jalan Depan', '$txtLebarJalanDepan M'),
                        _content('Luas Tanah', '$txtLuasTanah M'),
                        _content('Luas Bangunan', '$txtLuasBangunan M'),
                        _content('Status Kunci', txtStatusKunci),
                        _content('Kamar Tidur', '$txtKamarTidur Unit'),
                        _content('Kamar Mandi', '$txtKamarMandi Unit'),
                        _content('Kamar Mandi Pembantu',
                            '$txtKamarMandiPembantu Unit'),
                        _content('Ruang Tamu', '$txtRuangTamu Unit'),
                        _content('Ruang Makan', '$txtRuangMakan Unit'),
                        _content('Ruang Keluarga', '$txtRuangKeluarga Unit'),
                        _content('Dapur', '$txtDapur Unit'),
                        _content('Taman Depan', '$txtTamanDepan Unit'),
                        _content('Taman Belakang', '$txtTamanBelakang Unit'),
                        _content('Furniture', txtFurniture),
                        _content('Garasi', txtGarasi),
                        _content('Carport', txtCarport),
                        _content('Legalitas', txtLegalitas),
                        _content('Foto Copy Legalitas', txtFCLegalitas)
                      ]))
                ])));
  }

  Column _content(_title, _status) {
    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Container(
                child: Text(_title,
                    style: TextStyle(fontSize: 14, color: Colors.grey)))),
        Expanded(
            child:
                Container(child: Text(_status, style: TextStyle(fontSize: 14))))
      ]),
      SizedBox(height: 15)
    ]);
  }
}
