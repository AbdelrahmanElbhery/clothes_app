import 'package:flutter/cupertino.dart';

class ProductModel {
  String? title;
  String? uid;
  String? details;
  double? price_piece;
  int? minnumber;
  String? mainimage;
  String? secondimage;
  String? thirdimage;

  ProductModel({
    @required this.price_piece,
    @required this.title,
    @required this.uid,
    @required this.details,
    @required this.minnumber,
    @required this.mainimage,
    @required this.secondimage,
    @required this.thirdimage,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    details = json['details'];
    price_piece = json['price_piece'];
    uid = json['uid'];
    minnumber = json['minnumber'];
    mainimage = json['mainimage'];
    secondimage = json['secondimage'];
    thirdimage = json['thirdimage'];
  }
  Map<String, dynamic> todata() {
    return {
      'title': title,
      'uid': uid,
      'details': details,
      'price_piece': price_piece,
      'minnumber': minnumber,
      'mainimage': mainimage,
      'secondimage': secondimage,
      'thirdimage': thirdimage,
    };
  }
}
