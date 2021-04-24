import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/LoginCotroller/UserLoginController.dart';
import 'package:mymessager/shareds/CircleImage.dart';
import 'package:mymessager/shareds/CustomWidgetButtom.dart';
import 'package:mymessager/shareds/GoogleSignInButtonCustom.dart';
import 'package:mymessager/shareds/InputTextFieldWidget.dart';
import '../controllers/UserController/UserController.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final UserLoginController _userLoginController =
      Get.put(UserLoginController());
  final user = FirebaseAuth.instance.currentUser;
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/res/images/login_background.jpg"),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleImage(imagePath: "lib/res/images/icon_app.png"),
                SizedBox(
                  height: 20,
                ),
                GetX<UserLoginController>(builder: (controller) {
                  return InputTextFieldWidget(
                    hintText: "Enter email here",
                    labelText: "Email",
                    textEditingController: controller.emailEditController.value,
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                GetX<UserLoginController>(builder: (controller) {
                  return InputTextFieldWidget(
                    textEditingController: controller.passEditController.value,
                    hintText: "Enter password here",
                    labelText: "Password",
                    iconData: Icons.remove_red_eye,
                    onPress: () {
                      controller.toogleState();
                      print(controller.isHidePassword.toString());
                    },
                    obscureText: controller.isHidePassword.value,
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                        label: "Login",
                        iconData: Icons.login,
                        onPressed: () {
                          // Code dùng để demo
                          _userLoginController.emailEditController.value.text =
                              "19521542@gmail.com";
                          _userLoginController.passEditController.value.text =
                              "123456";
                          // Hết đoạn code demo
                          _userController.userLogin(
                              _userLoginController
                                  .emailEditController.value.text,
                              _userLoginController
                                  .passEditController.value.text);
                        }),
                    CustomButton(
                      label: "Register",
                      iconData: Icons.person_add,
                      onPressed: () {
                        Get.toNamed("/regis");
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInWithGoogleWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
