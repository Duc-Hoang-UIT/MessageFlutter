import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymessager/models/UserModel.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firebaseFirestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) => UserModel(
          id: documentSnapshot.id,
          name: documentSnapshot["name"],
          email: documentSnapshot["email"],
        );

    try {
      DocumentSnapshot _doc =
          await _firebaseFirestore.collection("users").doc(uid).get();
      return fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
