import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/helpers/helpers.dart';
import 'package:grad_project/models/firebase_response.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.visible, Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  late bool visible;
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  String? _emailError;
  String? _passwordError;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = navigateToRegisterScreen;
  }

  void navigateToRegisterScreen() {
    Navigator.pushNamed(context, '/register_screen');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              // width: 20,
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 60),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 39, left: 60),
              width: 300,
              child: TextField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  errorText: _emailError,
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 39,
                left: 60,
              ),
              width: 300,
              child: TextField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: _passwordError,
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 180),
              width: 300,
              child: TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/forget_password_screen'),
                child: const Text('Forget Password?'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              height: 53,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff415380),
                ),
                onPressed: () => performLogin(),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.visible,
              child: const SizedBox(
                // width: 20,
                height: 32,
              ),
            ),
            Visibility(
              visible: widget.visible,
              child: const Center(
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.visible,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/register_screen');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 39, left: 60),
                  width: 300,
                  height: 53,
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff415380),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/google.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 45,
                      ),
                      const Text(
                        'Login with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Visibility(
              visible: widget.visible,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: ' '),
                      TextSpan(
                        recognizer: _tapGestureRecognizer,
                        text: 'Create Now!',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void performLogin() {
    if (checkData()) login();
  }

  Future<void> login() async {
    FirebaseResponse response = await FbAuthController().signIn(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    print(response.message);
    if (response.success) {
      Navigator.pushReplacementNamed(context, '/home_screen');
      showSnackBar(context: context, message: response.message);
      // Navigator.pop(context);
    } else {
      showSnackBar(
          context: context,
          message: response.message,
          error: !response.success);
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      controlError();
      return true;
    }
    controlError();
    showSnackBar(
        context: context, message: "Enter required data!", error: true);
    return false;
  }

  void controlError() {
    setState(() {
      _emailError = _emailTextController.text.isEmpty
          ? 'Enter email address, Please!'
          : null;
      _passwordError = _passwordTextController.text.isEmpty
          ? 'Enter password, Please!'
          : null;
    });
  }
}
