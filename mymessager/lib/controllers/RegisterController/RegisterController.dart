import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/services/AuthenticationController.dart';

class RegisterController extends RxController {
  Authentication _authentication = Authentication();
  Rx<TextEditingController> emailEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> nameEditingController = TextEditingController().obs;
  Rx<TextEditingController> passwordEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> confirmEditingController =
      TextEditingController().obs;

  // ignore: missing_return
  bool isValid() {
    if (passwordEditingController.value.text
            .compareTo(confirmEditingController.value.text) !=
        0) {
      Get.snackbar("Warning", "Password confirm not exactly",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (passwordEditingController.value.text.length < 6) {
      Get.snackbar("Warning", "Password characters must more 6",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (nameEditingController.value.text.length < 1) {
      Get.snackbar("Warning", " Give the valid name and agian",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  Future<void> createAccount(String name, String email, String password) async {
    if (isValid()) {
      if (await _authentication.createUser(name, email, password)) {
        Get.back();
      }
    }
  }
}
