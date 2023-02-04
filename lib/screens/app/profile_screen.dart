import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      ),
      // body: StreamBuilder,
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Container(
      //       // margin: const EdgeInsets.symmetric(horizontal: 75, vertical: 35),
      //       width: 340,
      //       height: 60,
      //       decoration: BoxDecoration(
      //         color: const Color(0xff415380),
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           Text(
      //             'Doctor',
      //             style: TextStyle(color: Colors.white, fontSize: 40),
      //           )
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      //       child: TextField(
      //         // controller: _emailTextController,
      //         decoration: InputDecoration(
      //           // errorText: _emailError,
      //           hintText: 'Full Name',
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.grey,
      //             ),
      //           ),
      //           errorBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.red,
      //             ),
      //           ),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      //       child: TextField(
      //         // controller: _emailTextController,
      //         decoration: InputDecoration(
      //           // errorText: _emailError,
      //           hintText: 'Email Address',
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.grey,
      //             ),
      //           ),
      //           errorBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.red,
      //             ),
      //           ),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      //       child: TextField(
      //         // controller: _emailTextController,
      //         decoration: InputDecoration(
      //           // errorText: _emailError,
      //           hintText: 'Weight',
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.grey,
      //             ),
      //           ),
      //           errorBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.red,
      //             ),
      //           ),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      //       child: TextField(
      //         // controller: _emailTextController,
      //         decoration: InputDecoration(
      //           // errorText: _emailError,
      //           hintText: 'Height',
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.grey,
      //             ),
      //           ),
      //           errorBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.red,
      //             ),
      //           ),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      //       child: TextField(
      //         // controller: _emailTextController,
      //         decoration: InputDecoration(
      //           // errorText: _emailError,
      //           hintText: 'Age',
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.grey,
      //             ),
      //           ),
      //           errorBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.red,
      //             ),
      //           ),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(30),
      //             borderSide: const BorderSide(
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     // DropdownButtonFormField(
      //     //   items: [],
      //     //   onChanged: (value) {},
      //     // ),
      //   ],
      // ),
    );
  }
}
