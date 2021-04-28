import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymessager/models/UserModel.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firebaseFirestore.collection("users").doc(user.id).set({
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "ulrImage": user.ulrImage,
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
          ulrImage: documentSnapshot['ulrImage'],
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

  Future<List<UserModel>> getUserByName(String userName) async {
    getUserFromRaw(Map<String, dynamic> result) {
      return UserModel(
          id: result['id'],
          name: result['name'],
          email: result['email'],
          ulrImage: result['ulrImage']);
    }

    List<UserModel> users = [];

    await _firebaseFirestore
        .collection('users')
        .where('name', isEqualTo: userName)
        //.orderBy('name', descending: true)
        .get()
        .then((value) {
      for (var i in value.docs) {
        users.add(getUserFromRaw(i.data()));
      }
    });

    return users;
  }

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfo) async {
    return await _firebaseFirestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('chats')
        .doc(messageId)
        .set(messageInfo);
  }

  Future<bool> isExitsLastMessageRecord(String chatRoomId) async {
    var snapshot =
        await _firebaseFirestore.collection('chatRooms').doc(chatRoomId).get();
    return snapshot.exists;
  }

  Future updateLastMessage(String chatRoomId, Map messageInfo) async {
    bool isExitsRecord = await isExitsLastMessageRecord(chatRoomId);
    if (!isExitsRecord) {
      return await _firebaseFirestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .set(messageInfo);
    }

    return await _firebaseFirestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .update(messageInfo);
  }

  Stream<QuerySnapshot> chatsStream(String roomId) {
    Stream<QuerySnapshot> chatsDocumentStream = _firebaseFirestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('chats')
        .orderBy('ts', descending: true)
        .snapshots();
    return chatsDocumentStream;
  }


}
