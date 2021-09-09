class LoginModel {
  late bool status;
  late dynamic message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    // message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

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
  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.password,
      this.points = 0,
      this.credit = 0});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
      "email": email,
      "phone": phone,
      "password": password,
    };
  }

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    // image = json['image'];
    points = json['points'];
    credit = json['credit'];
    // token = json['token'];
  }
}
// _loginmodel = LoginModel.fromJson({})
