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

class UserForgotEmailModel {
  String? email;

  UserForgotEmailModel({this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class UserResetPassword {
  String? reset_token;
  String? password;

  UserResetPassword({this.reset_token, this.password});

  Map<String, dynamic> toJson() {
    return {
      'resetToken': reset_token,
      'password': password,
    };
  }
}

class UserForgotUsername {
  String? email;

  UserForgotUsername({this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
