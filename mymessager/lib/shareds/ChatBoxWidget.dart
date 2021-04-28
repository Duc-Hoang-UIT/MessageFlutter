import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/ChatRoomController/ChatRoomController.dart';
import 'package:mymessager/shareds/CircleAvatarImage.dart';

class ChatBoxWidget extends StatelessWidget {
  final String chatRoomId;

  const ChatBoxWidget({Key key, this.chatRoomId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('chats');

    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy('ts', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data.docs.length,
            reverse: true,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data.docs[index];
              // return Text(document.data()['message']);
              return Container(
                child: Stack(
                  children: [
                    Row(
                        mainAxisAlignment: Get.find<ChatRoomController>()
                                .isMessageSendByMe(document.data()['sendBy'])
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: Get.find<ChatRoomController>()
                                .isMessageSendByMe(document.data()['sendBy'])
                            ? <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                      color: Colors.blue[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                  child: Text(" " + document.data()['message']),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatarImage(
                                  width: 30,
                                  height: 30,
                                  ulrImage: document.data()['urlImage'],
                                ),
                              ]
                            : <Widget>[
                                CircleAvatarImage(
                                  width: 30,
                                  height: 30,
                                  ulrImage: document.data()['urlImage'],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                      color: Colors.blue[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                  child: Text(" " + document.data()['message']),
                                ),
                              ]),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
