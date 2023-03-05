import 'package:flutter/cupertino.dart';

class ArticleModel {
  String? title;
  String? uid;
  String? details;
  String? date;
  String? articleimage;

  ArticleModel({
    @required this.title,
    @required this.uid,
    @required this.details,
    @required this.date,
    @required this.articleimage,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    details = json['details'];
    date = json['date'];
    uid = json['uid'];
    articleimage = json['articleimage'];
  }
  Map<String, dynamic> todata() {
    return {
      'title': title,
      'uid': uid,
      'details': details,
      'date': date,
      'articleimage': articleimage,
    };
  }
}
