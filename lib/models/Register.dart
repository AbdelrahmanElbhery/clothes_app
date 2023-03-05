import 'package:flutter/cupertino.dart';

class SocialRegisterModel {
  String? name;
  String? uid;
  String? phone;
  String? email;
  String? image;

  SocialRegisterModel({
    @required this.email,
    @required this.name,
    @required this.uid,
    @required this.phone,
    @required this.image,
  });

  SocialRegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uid = json['uid'];
    image = json['image'];
  }
  Map<String, dynamic> todata() {
    return {
      'name': name,
      'uid': uid,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }
}
