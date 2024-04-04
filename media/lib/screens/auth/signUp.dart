import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:media/components/loading.dart';
import 'package:media/services/auth.dart';

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
  String name = '';
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
                      MaterialTextField(
                        hint: 'Name',
                        prefixIcon:
                            const Icon(Icons.person_2_outlined), // decoration:

                        //     textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (currentVal) =>
                            currentVal!.isEmpty ? 'Name cannot be empty' : null,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
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
                              onPressed: () async => widget.toggleSignIn(),
                              child: const Text(
                                'Sign in',
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
                                    dynamic result =
                                        await _authService.registerWithEmail(
                                            email, password, name);

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
                          ),
                        ],
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
