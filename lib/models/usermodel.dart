class UserModel {
  String? name;
  String? email;
  String? uid;
  String? phone;

  UserModel({this.name, this.email, this.uid, this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['phone'] = this.phone;
    return data;
  }
}
