import 'package:ecommerce_app/Features/services/auth_services.dart';
import 'package:ecommerce_app/commonwidgets/custom_button.dart';
import 'package:ecommerce_app/commonwidgets/custom_textfield.dart';
import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final signupkey = GlobalKey<FormState>();
  final signinkey = GlobalKey<FormState>();

  final AuthServices authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirm_passwordController =TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authServices.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          const Text(
            "WELCOME",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          ListTile(
            title: const Text(
              "Create Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                }),
          ),
          if (_auth == Auth.signup)
            Container(
              padding: const EdgeInsets.all(10),
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: signupkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _nameController,
                        hinttext: "Name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _emailController,
                        hinttext: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _passwordController,
                        hinttext: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _confirm_passwordController,
                        hinttext: "Confirm-Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          onTap: () {
                            if (signupkey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          text: "Sign Up")
                    ],
                  )),
            ),
          ListTile(
            title: const Text(
              "Sign-In.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                }),
          ),
          if (_auth == Auth.signin)
            Container(
              padding: const EdgeInsets.all(10),
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: signinkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _nameController,
                        hinttext: "Name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: _passwordController,
                        hinttext: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(onTap: () {}, text: "Sign Up")
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
