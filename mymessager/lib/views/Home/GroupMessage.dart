import 'package:flutter/material.dart';
import 'package:mymessager/shareds/ChatRoomsList.dart';

class GroupMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            SizedBox(
              height: 500,
              child: Column(
                children: [
                  ChatRoomList(),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
