import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_app/service/auth.dart';
import 'package:recycle_app/tools/constants.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final AuthService _auth = AuthService();
  String email = '';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 64, 92, 1),
        title: const Text('Reset Password'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.asset(
                'Background.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
            color: Colors.black54,
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter your email and we will send a password reset link.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          inputTextDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                      onChanged: ((value) {
                        email = value;
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          try {
                            await _auth.resetPassword(email);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Check your email!"),
                                );
                              },
                            );
                          } on FirebaseAuthException catch (e) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(e.message.toString()),
                                );
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      child: Text('Reset Password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
