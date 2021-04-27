import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/ChatRoomController/ChatRoomController.dart';
import 'package:mymessager/models/UserModel.dart';
import 'package:mymessager/shareds/CircleAvatarImage.dart';

class ChatRoomPage extends StatelessWidget {
  final ChatRoomController _chatRoomController = Get.find<ChatRoomController>();
  @override
  Widget build(BuildContext context) {
    UserModel guest = _chatRoomController.guest.value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatarImage(
                ulrImage: guest.ulrImage,
              ),
              Text("${guest.name}"),
            ],
          ),
          backgroundColor: Colors.blue[300],
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.phone), onPressed: () {}),
            IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  print(
                      'Line 38 : ${_chatRoomController.chatBox.length}');
                }),
          ],
        ),
        body: Container(
            child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: _chatRoomController.messageEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                      ),
                    )),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          await _chatRoomController.addMessage();
                          print("Chat Room Page: 68");
                          await _chatRoomController.fetchMessage();
                        })
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
