import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/models/person.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nameText = '';
  String weightText = '';
  String heightText = '';
  String ageText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  User user = FbAuthController().user;

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/edit_profile_screen'),
            icon: const Icon(
              Icons.edit,
              color: Color(0xff415380),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 45,
            ),
            child: Text(
              "Name",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 20,
            ),
            child: TextField(
              controller: TextEditingController(text: nameText),
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              readOnly: true,
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: _nameTextController.text,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
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
          const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 45,
            ),
            child: Text(
              "Age",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: TextField(
              controller: TextEditingController(text: ageText),
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              readOnly: true,
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: 'Height',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
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
          const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 45,
            ),
            child: Text(
              "Weight",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: TextField(
              controller: TextEditingController(text: weightText),
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              readOnly: true,
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: _nameTextController.text,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
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
          const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 45,
            ),
            child: Text(
              "Height",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff415380),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: TextField(
              controller: TextEditingController(text: heightText),
              style: const TextStyle(
                color: Color(0XFF415380),
              ),
              readOnly: true,
              decoration: InputDecoration(
                // errorText: _emailError,
                // hintText: 'Height',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
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
      ),
      // body: StreamBuilder<QuerySnapshot<Person>>(
      //   stream: FbFireStoreController().readUsers(),
      //   builder: (context, snapshot) {
      //     _getdata();
      //     print(nameText);
      //     return ListView.builder(
      //       itemCount: snapshot.data!.size,
      //       itemBuilder: (context, index) {
      //         // setState(() {
      //         //   nameText = snapshot.data!.docs[index].data().name;
      //         //   heightText = snapshot.data!.docs[index].data().height;
      //         //   weightText = snapshot.data!.docs[index].data().weight;
      //         // });
      //         // print(user.uid.runtimeType);
      //         print(snapshot.data!.docs[index].data().id.runtimeType);
      //         if (snapshot.data!.docs[index].data().id == user.uid) {
      //           return Column(
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(
      //                     left: 30, right: 30, bottom: 20),
      //                 child: TextField(
      //                   controller: _nameTextController,
      //                   decoration: InputDecoration(
      //                     // errorText: _emailError,
      //                     // hintText: snapshot.data!.docs[index].data().name,
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.grey,
      //                       ),
      //                     ),
      //                     errorBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.red,
      //                       ),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.blue,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(
      //                     left: 30, right: 30, bottom: 20),
      //                 child: TextField(
      //                   controller: _weightTextController,
      //                   decoration: InputDecoration(
      //                     // errorText: _emailError,
      //                     hintText: _nameTextController.text,
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.grey,
      //                       ),
      //                     ),
      //                     errorBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.red,
      //                       ),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.blue,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(
      //                     left: 30, right: 30, bottom: 20),
      //                 child: TextField(
      //                   controller: _heightTextController,
      //                   decoration: InputDecoration(
      //                     // errorText: _emailError,
      //                     hintText: 'Height',
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.grey,
      //                       ),
      //                     ),
      //                     errorBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.red,
      //                       ),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(30),
      //                       borderSide: const BorderSide(
      //                         color: Colors.blue,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           );
      //         } else {
      //           return Center();
      //         }
      //       },
      //     );
      //   },
      // ),
    );
  }

  void _getdata() async {
    User user = FbAuthController().user;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        nameText = userData.data()!['name'];
        weightText = userData.data()!['weight'].toString();
        heightText = userData.data()!['height'].toString();
        ageText = userData.data()!['age'].toString();
      });
    });
  }
}
