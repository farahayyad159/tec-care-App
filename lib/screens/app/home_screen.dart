import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/models/exercise.dart';
import 'package:grad_project/screens/app/exercise_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _searchTextController;
  final List<String> _muscleName = <String>[
    'back',
    'cardio',
    'chest',
    'lower arms',
    'lower legs',
    'neck',
    'shoulders',
    'upper arms',
    'upper legs',
    'waist'
  ];
  var selectedType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Color(0XFF415380),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (!scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: const Icon(
            Icons.menu,
            color: Color(0XFF415380),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Color(0XFF415380),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                'images/yoga.jpg',
                fit: BoxFit.fill,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/profile_screen');
              },
              leading: const Icon(
                Icons.person,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/login_screen');
              },
              leading: const Icon(
                Icons.local_hospital_outlined,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Contact a doctor',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/references_screen');
              },
              leading: const Icon(
                Icons.insert_link,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Reference Links',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/contact_screen');
              },
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Connect with us',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await FbAuthController().signOut();
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
              leading: const Icon(
                Icons.logout,
                color: Color(0XFF415380),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                    //             fontSize: 14,
                    //             color: Colors.black,
                    //           ),),
                    ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   width: 400,
          //   child: TextField(
          //     controller: _searchTextController,
          //     decoration: InputDecoration(
          //       prefixIcon: const Icon(Icons.search),
          //       hintText: 'Search',
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(5),
          //         borderSide: const BorderSide(
          //           color: Color(0XFF415380),
          //         ),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         borderSide: const BorderSide(
          //           color: Color(0XFF415380),
          //         ),
          //       ),
          //     ),
          //     onChanged: (String value) {
          //       setState(() {});
          //     },
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.filter_alt_outlined,
                color: Color(0XFF415380),
                size: 22,
              ),
              const SizedBox(
                width: 20,
              ),
              DropdownButton(
                items: _muscleName
                    .map(
                      (value) => DropdownMenuItem(
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color(0XFF415380),
                            fontSize: 18,
                          ),
                        ),
                        value: value,
                      ),
                    )
                    .toList(),
                onChanged: (selected) {
                  setState(() {
                    selectedType = selected;
                  });
                },
                value: selectedType,
                hint: const Text(
                  'Pick a body part',
                  style: TextStyle(
                    color: Color(0XFF415380),
                    fontSize: 20,
                  ),
                ),
                isExpanded: false,
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Exercise>>(
              stream: FbFireStoreController().read(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final muscleName = snapshot.data!.docs[index].data().muscleName;
                      if (selectedType == '' || selectedType == null) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ExerciseScreen(exercise: snapshot.data!.docs[index].data()),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: 380,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  child: Image.asset(
                                    'images/exercise1.jpg',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                ),
                                // Text(snapshot.data!.docs[index].id),
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 0),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .name,
                                          style: const TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 220,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .description,
                                          style: const TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      else if (selectedType != null && muscleName
                              .toLowerCase()
                              .contains(selectedType!.toLowerCase())) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ExerciseScreen(exercise: snapshot.data!.docs[index].data()),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: 380,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  child: Image.asset(
                                    'images/exercise1.jpg',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                ),
                                // Text(snapshot.data!.docs[index].id),
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()
                                              .name,
                                          style: const TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 220,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 4),
                                        child: const Text(
                                          "Circuit training is when you combine and alternate between six to ten exercises to target different muscle groups",
                                          style: TextStyle(
                                            color: Color(0XFF415380),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Center();
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'NO DATA',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 45,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
