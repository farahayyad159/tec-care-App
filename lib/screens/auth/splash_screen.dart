import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1500),
          () {
        String route = FbAuthController().loggedIn ? "/home_screen": "/guard_screen";
          Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/splash.png',

        ),
      ),
    );
  }
}
