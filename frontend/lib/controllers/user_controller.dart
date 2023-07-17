import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/user_model.dart';

class UserController {
  static const String baseUrl = 'http://localhost:3000';
  static const String registerEndPoint = '/register-user';
  static const String loginEndPoint = '/user-login';
  static const String forgotPasswordEndPoint = '/forgot-password';
  static const String forgotUsernameEndPoint = '/forgot-username';
  static const String resetPasswordEndPoint = '/reset-password';

  Future<void> registerUser(UserRegisterModel user) async {
    final url = Uri.parse(baseUrl + registerEndPoint);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(user.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        print('User berhasil didaftar');
      } else {
        print('daftar gagal');
      }
    } catch (e) {
      print('Terjadi kesalahan : $e.toString()');
      throw e;
    }
  }

  Future<Map<String, dynamic>> loginUser(UserLoginModel user) async {
    final url = Uri.parse(baseUrl + loginEndPoint);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(user.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] == "Login Berhasil") {
          print("Login berhasil");
        } else {
          print("Login gagal");
        }
        return responseData;
      } else {
        print("Login gagal");
      }
      return {};
    } catch (e) {
      print("Terjadi kesalahan: ${e.toString()}");
      throw e;
    }
  }

  Future<void> forgotPassword(UserForgotEmailModel email) async {
    final url = Uri.parse(baseUrl + forgotPasswordEndPoint);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(email.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("token reset terkirim");
      } else {
        print("token reset gagal dikirm");
      }
    } catch (e) {
      throw e;
    }
  }

  // Future<void> validResetToken(UserValidTokenModel reset_token) async {
  //   final url = Uri.parse(baseUrl + validTokenEndPoint);
  //   final headers = {'Content-Type': 'application/json'};
  //   final body = json.encode(reset_token.toJson());

  //   try {
  //     final response = await http.post(url, headers: headers, body: body);

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       if (responseData['data'] != null) {
  //         print("Token Valid");
  //       } else {
  //         print("Token tidak valid");
  //       }
  //     } else {
  //       print("gagal validasi token");
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<void> resetPassword(UserResetPassword newpassword) async {
    final url = Uri.parse(baseUrl + resetPasswordEndPoint);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(newpassword.toJson());

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("sukssess reset password");
      } else {
        print("gagal reset password");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> forgotUsername(UserForgotUsername username) async {
    final url = Uri.parse(baseUrl + forgotUsernameEndPoint);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(username.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("suksess kirim username");
      } else {
        print("gagak kirim username");
      }
    } catch (e) {
      throw e;
    }
  }
}
