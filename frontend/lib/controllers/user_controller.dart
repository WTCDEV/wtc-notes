import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/user_model.dart';

class UserController {
  static const String baseUrl = 'http://localhost:3000';
  static const String registerEndPoint = '/register-user';
  static const String loginEndPoint = '/user-login';

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
      return {}; // Kembalikan Map kosong jika status code bukan 200
    } catch (e) {
      print("Terjadi kesalahan: ${e.toString()}");
      throw e;
    }
  }
}
