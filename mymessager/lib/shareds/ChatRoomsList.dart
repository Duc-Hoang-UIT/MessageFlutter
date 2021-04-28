import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/ChatRoomController/ChatRoomController.dart';
import 'package:mymessager/controllers/UserController/UserController.dart';
import 'package:mymessager/shareds/CircleAvatarImage.dart';

class ChatRoomList extends StatelessWidget {
  final String master = Get.find<UserController>().userModel.id;
  final ChatRoomController chatRoomController = Get.put(ChatRoomController());
  @override
  Widget build(BuildContext context) {
    Query chatRooms = FirebaseFirestore.instance
        .collection("chatRooms")
        .where('chatRoomId', isGreaterThan: master);
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return SizedBox(
          height: 500,
          child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data.docs[index];
                return Container(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () async {
                          // print("Hello + world");
                          chatRoomController.roomId.value =
                              document.data()['chatRoomId'];
                          chatRoomController.master =
                              Get.find<UserController>().userModel;
                         await chatRoomController.findGuestByRoomId(
                              '${document.data()['chatRoomId']}');

                          Get.toNamed('/chpage');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(),
                          ),
                          child: Row(
                            children: [
                              CircleAvatarImage(
                                ulrImage: document.data()['urlImage'],
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                  decoration: ShapeDecoration(
                                      color: Colors.blue[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      )),
                                  child: Text(document.data()['lastMessage'])),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
