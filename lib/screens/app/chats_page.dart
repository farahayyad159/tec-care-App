import 'package:grad_project/chat_widgets/chat_body_widget.dart';
import 'package:grad_project/controllers/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/models/chat_user.dart';
import 'package:grad_project/screens/app/profile_screen.dart';

import '../../controllers/fb_auth_controller.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Doctor Chat',
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
                  Navigator.pushNamed(context, '/home_screen');
                },
                leading: const Icon(
                  Icons.home,
                  color: Color(0XFF415380),
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatsPage(),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.local_hospital_outlined,
                  color: Color(0XFF415380),
                ),
                title: const Text(
                  'Doctors chat',
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
        body: SafeArea(
          child: StreamBuilder<Stream<List<ChatUser>>>(
            stream: FirebaseApi.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final users = snapshot.data;

                    if (users!.isEmpty) {
                      return buildText('No Users Found');
                    } else {
                      return Column(
                        children: [
                          ChatBodyWidget(users: users)
                        ],
                      );
                    }
                  }
              }
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
