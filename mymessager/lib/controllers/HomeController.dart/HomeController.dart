import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/views/Home/MenuLayout.dart';
import 'package:mymessager/views/Home/ProfileLayout.dart';
import 'package:mymessager/views/Home/SearchLayout.dart';

import '../UserController/UserController.dart';

class HomeController extends RxController {
  RxInt currentTagIndex = 0.obs;

  Widget getBody() {
    if (currentTagIndex.value == 0) {
      return MenuLayout();
    }
    if (currentTagIndex.value == 1) {
      return SearchLayout();
    }
    return ProfileLayout(userModel: Get.find<UserController>().userModel);
  }
}
