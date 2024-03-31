import 'package:flutter/material.dart';
import 'package:flutter_sandbox/model/CustomUser.dart';
import 'package:flutter_sandbox/services/authService.dart';
import 'package:flutter_sandbox/shared/loading.dart';
import 'package:material_text_fields/material_text_fields.dart';

class SignIn extends StatefulWidget {
  final Function toggleSignUp;

  const SignIn({super.key, required this.toggleSignUp});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey();

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
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () async => widget.toggleSignUp(),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    CustomUser? result = await _authService
                                        .signInWithEmail(email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Could not sign in.';
                                      });
                                    }
                                  }
                                },
                                child: const Text('Sign in',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          CustomUser? result = await _authService.signInAnon();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Could not sign in.';
                            });
                          }
                        },
                        child: const Text('Continue as guest'),
                      ),
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
