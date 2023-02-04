import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/models/exercise.dart';
import 'package:grad_project/models/person.dart';

class FbFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static FbFireStoreController? _instance;

  FbFireStoreController._();

  factory FbFireStoreController() {
    return _instance ??= FbFireStoreController._();
  }

  //Create User Method
  Future<bool> createUser(Person person) {
    return _fireStore
        .collection('users').doc(person.id)
        .set(person.toMap())
        .then((value) => true)
        .catchError((e) => false);
  }

  // Read method
  Stream<QuerySnapshot<Exercise>> read() async* {
    yield* _fireStore
        .collection('exercises')
        .withConverter<Exercise>(
          fromFirestore: (snapshot, options) =>
              Exercise.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        )
        .snapshots();
  }

  // Stream<QuerySnapshot<Person>> readUser(String id)  async*{
  //  yield* _fireStore
  //       .collection('users').path(id)
  //       .then((value) => true)
  //       .catchError((e) => false);
  // }
  Future<bool> readUser(String id) async{
    return await _fireStore
        .collection('users')
        .doc(id)
        .get()
        .then((value) => true)
        .catchError((e) => false);
  }
}
