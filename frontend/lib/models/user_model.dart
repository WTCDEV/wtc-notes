class UserRegisterModel {
  String? username;
  String? email;
  String? password;

  UserRegisterModel({this.username, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class UserLoginModel {
  String? username;
  String? password;

  UserLoginModel({this.username, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
