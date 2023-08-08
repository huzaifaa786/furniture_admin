// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:furniture_admin/services/auth_service.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  void goto() async {
    await Future.delayed(Duration(seconds: 5));
    Get.put(AuthService());
  }
}

initScreen(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SizedBox(
      width: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Image(image: AssetImage("assets/images/splashLogo.png"))
        ],
      ),
    ),
  );
}
