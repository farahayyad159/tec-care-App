import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/models/chat_user.dart';
import 'package:grad_project/controllers/fb_auth_controller.dart';
import '../utils.dart';
import 'fb_firestore_controller.dart';

class FirebaseApi {
  static Future<Stream<List<ChatUser>>> getUsers() async {
    User user = FbAuthController().user;
    Future<bool> isDoctor = FbFireStoreController().isDoctor(user.email!);
    print({user});
    if (await isDoctor) {
      return FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .transform(Utils.transformer(ChatUser.fromJson));
    } else {
      return FirebaseFirestore.instance
          .collection('doctors')
          .snapshots()
          .transform(Utils.transformer(ChatUser.fromJson));
    }
  }

  static Future uploadMessage(String id, String message) async {
    User user = FbAuthController().user;
    Future<bool> isDoctor = FbFireStoreController().isDoctor(user.email!);
    final newMessage = Message(
      id: user.uid,
      name: user.displayName!,
      message: message,
      createdAt: DateTime.now(),
    );
    if (await isDoctor) {
      final refMessages =
          FirebaseFirestore.instance.collection('chats/$id/messages');

      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers
          .doc(id)
          .update({UserField.lastMessageTime: DateTime.now()});
    } else {
      final refMessages =
          FirebaseFirestore.instance.collection('chats/${user.uid}/messages');
      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers
          .doc(user.uid)
          .update({UserField.lastMessageTime: DateTime.now()});
    }
  }

  static Future<Stream<List<Message>>> getMessages(String id) async {
    User user = FbAuthController().user;
    Future<bool> isDoctor = FbFireStoreController().isDoctor(user.email!);

    if (await isDoctor) {
      return FirebaseFirestore.instance
          .collection('chats/$id/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    } else {
      print('gettttttttttt' + id);
      return FirebaseFirestore.instance
          .collection('chats/${user.uid}/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    }
  }
}
