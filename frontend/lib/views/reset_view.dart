import 'package:flutter/material.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/views/login_view.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetTokenController = TextEditingController();
  String? resetMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final newPassword = UserResetPassword(
      reset_token: _resetTokenController.text,
      password: _passwordController.text,
    );
    try {
      await UserController().resetPassword(newPassword);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    } catch (e) {
      setState(() {
        resetMessage = "Gagal reset password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _resetTokenController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Reset Token',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                onChanged: (value) {},
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password Baru',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: _resetPassword,
                child: const Text("Reset Password"),
              ),
              if (resetMessage != null) Text(resetMessage!),
            ],
          ),
        ),
      ),
    );
  }
}
