import 'package:flutter/material.dart';
import 'package:mymessager/models/UserModel.dart';

class ProfileLayout extends StatelessWidget {
  final UserModel userModel;

  const ProfileLayout({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Profile Layout"),
              Text("${userModel.name}"),
              Text("${userModel.email}"),
            ],
          ),
        ),
      ),
    );
  }
}
