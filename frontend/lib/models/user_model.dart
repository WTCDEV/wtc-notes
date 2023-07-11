class UserRegisterModel {
  String? username;
  String? email;
  String? password;

  UserRegisterModel({this.username, this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
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
