import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/models/person.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  User user;
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameTextController;
  late TextEditingController _weightTextController;
  late TextEditingController _heightTextController;

  String nameText = '';
  String weightText = '';
  String heightText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController(text: nameText);
    _heightTextController = TextEditingController(text: heightText);
    _weightTextController = TextEditingController(text: weightText);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _heightTextController.dispose();
    _weightTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.user!.uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xff415380),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff415380),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Person>>(
        stream: FbFireStoreController().readUsers(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {

              // setState(() {
              //   nameText = snapshot.data!.docs[index].data().name;
              //   heightText = snapshot.data!.docs[index].data().height;
              //   weightText = snapshot.data!.docs[index].data().weight;
              // });
              if (snapshot.data!.docs[index].data().id == widget.user.uid) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20),
                      child: TextField(
                        controller: _nameTextController,
                        decoration: InputDecoration(
                          // errorText: _emailError,
                          hintText: snapshot.data!.docs[index].data().name,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20),
                      child: TextField(
                        controller: _weightTextController,
                        decoration: InputDecoration(
                          // errorText: _emailError,
                          hintText: _nameTextController.text,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20),
                      child: TextField(
                        controller: _heightTextController,
                        decoration: InputDecoration(
                          // errorText: _emailError,
                          hintText: 'Height',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center();
              }
            },
          );
        },
      ),
    );
  }
}
