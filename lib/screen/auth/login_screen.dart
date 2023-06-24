// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture_admin/screen/main_screen.dart/main.dart';
import 'package:furniture_admin/static/input_field1.dart';
import 'package:furniture_admin/static/large_button.dart';
import 'package:furniture_admin/values/Validator.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/loginback.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/splashLogo.png"),
                        height: 100,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 250, 250, 250),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: mainColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Text(
                                      'Back to Account',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: InputField1(
                                      icon: 'assets/images/email.svg',
                                      hint: 'Email Address',
                                      // controller: loginController.email,
                                      type: TextInputType.emailAddress,
                                      // validate: loginController
                                      // .validateSignInForm,
                                      validator: (field) =>
                                          Validators.emailValidator(field),
                                    ),
                                  ),
                                  InputField1(
                                    icon: 'assets/images/lock.svg',
                                    hint: 'Password',
                                    obscure: true,
                                    // controller: loginController.password,
                                    // validate:
                                    //     loginController.validateSignInForm,
                                    validator: (field) =>
                                        Validators.emptyStringValidator(
                                            field, '*password'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  LargeButton(
                                    title: 'Login',
                                    sreenRatio: 0.9,
                                    onPressed: () {
                                      Get.to(() => HomeScreen());
                                    },
                                    textcolor: Colors.white,
                                    buttonWidth: 0.95,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
