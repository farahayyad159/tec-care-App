import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/models/message.dart';
import 'package:grad_project/models/user.dart';

import '../utils.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers(bool isDoctor) {
    if (isDoctor) {
      return FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .transform(Utils.transformer(User.fromJson));
    } else {
      return FirebaseFirestore.instance
          .collection('doctors')
          .snapshots()
          .transform(Utils.transformer(User.fromJson));
    }
  }

  static Future uploadMessage(bool isDoctor, String id, String message) async {
    if (isDoctor) {
      final refMessages =
          FirebaseFirestore.instance.collection('chats/$id/messages');

      final newMessage = Message(
        id: "myId",
        name: "myUsername",
        message: message,
        createdAt: DateTime.now(),
      );
      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers
          .doc(id)
          .update({UserField.lastMessageTime: DateTime.now()});
    } else {
      print('setttt' + id);
      var myId = "teest";
      final refMessages =
          FirebaseFirestore.instance.collection('chats/$myId/messages');

      final newMessage = Message(
        id: "myId",
        name: "myUsername",
        message: message,
        createdAt: DateTime.now(),
      );
      await refMessages.add(newMessage.toJson());

      final refUsers = FirebaseFirestore.instance.collection('users');
      await refUsers
          .doc("myId")
          .update({UserField.lastMessageTime: DateTime.now()});
    }
  }

  static Stream<List<Message>> getMessages(bool isDoctor, String id) {
    if (isDoctor) {
      return FirebaseFirestore.instance
          .collection('chats/$id/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    } else {
      print('gettttttttttt' + id);
      var myId = "teest";
      return FirebaseFirestore.instance
          .collection('chats/$myId/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    }
  }
}
