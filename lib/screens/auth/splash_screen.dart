import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/screens/app/home_screen.dart';

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
        bool isLoggedIn = FbAuthController().loggedIn;
        if (isLoggedIn) {
          // User user = FbAuthController().user;
          Future<bool> _isDoctor = FbFireStoreController().doesDoctorExist(FbAuthController().user.email!);
          // print(FbFireStoreController().readUser(user!.uid).);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: FbAuthController().user, isDoctor: Future.value(_isDoctor).toString() == 'true'),
            ),
          );
        } else {
          Navigator.pushReplacementNamed(context, '/guard_screen');
        }
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
