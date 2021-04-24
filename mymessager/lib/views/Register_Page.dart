import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/RegisterController/RegisterController.dart';
import 'package:mymessager/shareds/CustomWidgetButtom.dart';
import 'package:mymessager/shareds/InputTextFieldWidget.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/res/images/register_background"),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                InputTextFieldWidget(
                  textEditingController:
                      _registerController.nameEditingController.value,
                  obscureText: false,
                  hintText: "Enter your name here",
                  labelText: "Your name ",
                ),
                SizedBox(
                  height: 20,
                ),
                InputTextFieldWidget(
                  textEditingController:
                      _registerController.emailEditingController.value,
                  hintText: "Enter email here",
                  labelText: "Email",
                ),
                SizedBox(
                  height: 20,
                ),
                InputTextFieldWidget(
                  textEditingController:
                      _registerController.passwordEditingController.value,
                  obscureText: true,
                  hintText: "Enter your password here",
                  labelText: "Enter Password ",
                ),
                SizedBox(height: 20),
                InputTextFieldWidget(
                  textEditingController:
                      _registerController.confirmEditingController.value,
                  obscureText: true,
                  labelText: "Confirm your password",
                  hintText: "Repeat your password",
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      label: "Register",
                      iconData: Icons.person_add_alt,
                      onPressed: () {
                        _registerController.createAccount(
                            _registerController
                                .nameEditingController.value.text,
                            _registerController
                                .emailEditingController.value.text,
                            _registerController
                                .passwordEditingController.value.text);
                      },
                    ),
                    CustomButton(
                      label: "Cancel",
                      iconData: Icons.arrow_back,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
