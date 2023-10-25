import 'package:firebase/services/authService.dart';
import 'package:firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';

class SignUp extends StatefulWidget {
  final Function toggleSignIn;

  const SignUp({super.key, required this.toggleSignIn});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign up to Brew Crew'),
              actions: [
                IconButton(
                    onPressed: () {
                      widget.toggleSignIn();
                    },
                    icon: const Icon(Icons.person))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      MaterialTextField(
                        hint: 'Email',
                        prefixIcon:
                            const Icon(Icons.email_outlined), // decoration:

                        //     textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (currentVal) => currentVal!.isEmpty
                            ? 'Email cannot be empty'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      MaterialTextField(
                        hint: 'Password',
                        prefixIcon:
                            const Icon(Icons.lock_outline), // decoration:
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined), // decoration:
                        ),

                        keyboardType: TextInputType.emailAddress,
                        // decoration:
                        //     textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (currentVal) => currentVal!.isEmpty
                            ? 'Password cannot be empty'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        obscureText: !showPassword,

                        // icon: Icon(Icons.password),
                        // onPressed: () {
                        //   setState(() {
                        //     showPassword = !showPasswordÏ
                        //   });
                        // },
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _authService
                                  .registerWithEmail(email, password);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Could not create an account!';
                                });
                              }
                            }
                          },
                          child: const Text('Sign up',
                              style: TextStyle(color: Colors.white))),
                      const SizedBox(height: 20),
                      Text(error,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14))
                    ],
                  ),
                )),
          );
  }
}
