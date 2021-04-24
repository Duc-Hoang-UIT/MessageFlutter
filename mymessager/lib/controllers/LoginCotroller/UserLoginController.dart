import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginController extends RxController {
  var emailEditController = TextEditingController().obs;

  var passEditController = TextEditingController().obs;
  RxBool isHidePassword = RxBool(true);

  toogleState() {
    isHidePassword.value = !(isHidePassword.value);
    print("...In tootle State");
  }
}
