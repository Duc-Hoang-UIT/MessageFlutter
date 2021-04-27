import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/UserController/UserController.dart';
import 'package:mymessager/models/UserModel.dart';
import 'package:mymessager/shareds/CircleAvatarImage.dart';

class ProfileLayout extends StatelessWidget {
  final UserModel userModel = Get.find<UserController>().userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: (userModel.ulrImage != null)
                ? [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatarImage(
                      ulrImage: userModel.ulrImage,
                    ),
                    Text("${userModel.name}"),
                    Text("${userModel.email}"),
                  ]
                : <Container>[],
          ),
        ),
      ),
    );
  }
}
