import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/UserController/UserController.dart';

class SignInWithGoogleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 280,
      child: InkWell(
        onTap: () {
          Get.find<UserController>().userSignInwithGoogle();
        },
        child: Ink(
          decoration: ShapeDecoration(
              color: Colors.blue.withAlpha(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Image.asset(
                    'lib/res/images/icon_google.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 12),
                  Text('Sign in with Google'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
