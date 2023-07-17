import 'package:flutter/material.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/shared/shared_preferences.dart';
import 'package:frontend/views/forgot_username_view.dart';

import 'forgot.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final UserController _userController = UserController();
  final _formKey = GlobalKey<FormState>();

  late String _username;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            margin: const EdgeInsets.only(
              top: 70,
              bottom: 80,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/iconbocchi.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            'Login Akun',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan Username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan Password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _loginUser();
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(
                        MediaQuery.of(context).size.width * 0.6,
                        MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/register');
            },
            child: Text("Not have account ? register!"),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPage()),
              );
            },
            child: Text("Forgot Password?"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotUsernamPage()),
              );
            },
            child: Text("Forgot Username?"),
          ),
        ],
      ),
    );
  }

  Future<void> _loginUser() async {
    try {
      final response = await _userController.loginUser(
        UserLoginModel(
          username: _username,
          password: _password,
        ),
      );

      if (response['message'] == 'Login Berhasil') {
        await SharedPrefUtils.saveUserData(
            response['username'], response['email']);
        await SharedPrefUtils.saveIdUser(response['id_user']);
        await SharedPrefUtils.saveIsLoggedIn(true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil login'),
            duration: Duration(seconds: 2),
          ),
        );

        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login gagal'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat login'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
