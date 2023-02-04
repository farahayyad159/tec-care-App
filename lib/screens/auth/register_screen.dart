import 'dart:ui';

import 'package:dob_input_field/dob_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/helpers/helpers.dart';
import 'package:grad_project/models/firebase_response.dart';
import 'package:grad_project/models/person.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  String? _emailError;
  String? _passwordError;
  String? _nameError;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _dateTextController;
  late TextEditingController _heightTextController;
  late TextEditingController _weightTextController;

  @override
  void initState() {
    // TODO: implement initState
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _nameTextController = TextEditingController();
    _dateTextController = TextEditingController();
    _heightTextController = TextEditingController();
    _weightTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameTextController.dispose();
    _dateTextController.dispose();
    _heightTextController.dispose();
    _weightTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 60,
                top: 20,
              ),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                keyboardType: TextInputType.name,
                controller: _nameTextController,
                decoration: InputDecoration(
                  errorText: _nameError,
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Full name',
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
            // Container(
            //   margin: const EdgeInsets.only(top: 20, left: 60),
            //   width: 300,
            //   decoration: BoxDecoration(
            //     border: Border(bottom: BorderSide(color: Colors.grey)),
            //   ),
            //   child: DOBInputField(
            //     firstDate: DateTime(1900),
            //     lastDate: DateTime.now(),
            //     showLabel: true,
            //     autovalidateMode: AutovalidateMode.always,
            //     fieldLabelText: "Date of birth",
            //   ),
            //   // child: TextField(
            //   //   keyboardType: TextInputType.datetime,
            //   //   controller: _dateTextController,
            //   //   decoration: InputDecoration(
            //   //     prefixIcon: const Icon(Icons.date_range),
            //   //     hintText: 'Date of birth',
            //   //     enabledBorder: OutlineInputBorder(
            //   //       borderRadius: BorderRadius.circular(15),
            //   //     ),
            //   //     errorBorder: OutlineInputBorder(
            //   //       borderRadius: BorderRadius.circular(15),
            //   //       borderSide: const BorderSide(
            //   //         color: Colors.red,
            //   //       ),
            //   //     ),
            //   //     focusedBorder: OutlineInputBorder(
            //   //       borderRadius: BorderRadius.circular(15),
            //   //       borderSide: const BorderSide(
            //   //         color: Colors.blue,
            //   //       ),
            //   //     ),
            //   //   ),
            //   // ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                controller: _heightTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.height),
                  hintText: 'Height',
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
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                controller: _weightTextController,
                decoration: InputDecoration(
                  // errorText: _passwordError,
                  prefixIcon: const Icon(Icons.monitor_weight_outlined),
                  hintText: 'Weight',
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
              margin: const EdgeInsets.only(top: 20, left: 60),
              width: 300,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
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
              margin: const EdgeInsets.only(top: 20, left: 60),
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
              margin: const EdgeInsets.only(top: 39, left: 60),
              width: 300,
              height: 53,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff415380),
                ),
                onPressed: () async {
                  await performRegister();
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              // width: 20,
              height: 32,
            ),
            const Center(
              child: Text(
                "Or",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
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
                    width: 30,
                  ),
                  const Text(
                    'Sign up with Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     Text('Do you have an account?'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) await register();
  }

  Future<void> register() async {
    // FirebaseResponse response = await FbAuthController().createAccount(
    //     email: _emailTextController.text,
    //     password: _passwordTextController.text,
    //     name: _nameTextController.text);
    FirebaseResponse response = await FbAuthController().createAccount(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        name: _nameTextController.text);
    Person person = Person();
      person.id = response.credential!.user!.uid;
      person.name = _nameTextController.text;
      person.height = _heightTextController.text;
      person.weight = _weightTextController.text;
      person.email = _emailTextController.text;
    // person.dateOfBirth = DateTime.parse(_dateTextController.text);
    Future<bool> fireStoreResult = FbFireStoreController()
        .createUser(person)
        .then((value) => true)
        .catchError((e) => false);
    String fireStoreResponse = fireStoreResult.toString();
    if (response.credential != null && fireStoreResponse == 'true') {
      Navigator.pop(context);
      clearData();
      showSnackBar(context: context, message: "User created successfully");
    } else {
      showSnackBar(
          context: context,
          message: response.message,
          error: !response.success);
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _nameTextController.text.isNotEmpty) {
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
      _nameError =
      _nameTextController.text.isEmpty ? 'Enter username, Please!' : null;
    });
  }
  void clearData(){
    _emailTextController.text = '';
    _nameTextController.text = '';
    _passwordTextController.text = '';
    _heightTextController.text = '';
    _weightTextController.text = '';
  }
}