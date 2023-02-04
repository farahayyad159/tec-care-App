import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import 'package:grad_project/controllers/fb_firestore_controller.dart';
import 'package:grad_project/models/exercise.dart';
import 'package:grad_project/screens/app/home_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({required this.exercise, Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
  Exercise exercise;
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _counter = 0;
  late YoutubePlayerController _youtubePlayerController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.exercise.urlVideo)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        isLive: false,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _youtubePlayerController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        //   onReady: () {
        // _youtubePlayerController.addListener(listener);
        // },
      ),
      builder: (context, player) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              widget.exercise.name,
              style: const TextStyle(
                color: Color(0XFF415380),
                fontWeight: FontWeight.bold,
                fontSize: 22,
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(user: null),
                      ),
                    );
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
                    Icons.timer_outlined,
                    color: Color(0XFF415380),
                  ),
                  title: const Text(
                    'Reminders',
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
          body: ListView(
            children: [
              player,
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  widget.exercise.description,
                  style: const TextStyle(
                    color: Color(0XFF415380),
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _counter = 0;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff415380),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: Icon(
                              Icons.lock_reset_sharp,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Reset',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff415380),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _counter.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ++_counter;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff415380),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: const [
                          SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Center(
                            child: Text(
                              'Plus',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
