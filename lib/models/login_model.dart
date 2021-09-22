import 'home_model.dart';

class LoginModel {
  late bool status;
  late dynamic message;
  UserData? data;
}
// LoginModel.fromJson(Map<String, dynamic> json) {
//   data = json['data'] != null ? UserData.fromJson(json['data']) : null;
//   // status = json['status'];
//   // message = json['message'];
// }

class UserData {
  late String id;
  late String name;
  late String password;
  late String email;
  late String phone;
  late int points;
  late int credit;
  // late String image;
  // late String? token;

  // named constructor
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.points = 0,
    this.credit = 0,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> x = {
      "name": name,
      "id": id,
      "email": email,
      "phone": phone,
      "password": password,
      "points": points,
      "credit": credit,
    };
    print("toMap Result\n $x");
    return x;
  }
}

// UserData.fromJson(Map<String, dynamic> json) {
//   id = json['id'];
//   name = json['name'];
//   email = json['email'];
//   phone = json['phone'];
//   points = json['points'];
//   credit = json['credit'];
//   // image = json['image'];
//   // token = json['token'];
// }
