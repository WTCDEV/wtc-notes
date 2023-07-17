import 'package:flutter/material.dart';
import 'package:frontend/views/login_view.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class ForgotUsernamPage extends StatefulWidget {
  const ForgotUsernamPage({Key? key}) : super(key: key);

  @override
  State<ForgotUsernamPage> createState() => _ForgotUsernamPageState();
}

class _ForgotUsernamPageState extends State<ForgotUsernamPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final emailModel = UserForgotUsername(email: _emailController.text);
      try {
        await UserController().forgotUsername(emailModel);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      } catch (e) {
        print("$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      helperText: 'Enter your email address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add any other validation rules if needed
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: _sendEmail,
                    child: const Text("kirim"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
