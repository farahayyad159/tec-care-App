import 'package:grad_project/chat_widgets/messages_widget.dart';
import 'package:grad_project/chat_widgets/new_message_widget.dart';
import 'package:grad_project/chat_widgets/profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/models/user.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    required this.user,
     Key? key,
  }) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(id: widget.user.id),
                ),
              ),
              NewMessageWidget(id: widget.user.id)
            ],
          ),
        ),
      );
}
