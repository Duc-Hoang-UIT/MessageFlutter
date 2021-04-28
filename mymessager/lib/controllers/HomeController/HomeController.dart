import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/models/UserModel.dart';
import 'package:mymessager/services/Database.dart';
import 'package:mymessager/views/Home/GroupMessage.dart';
import 'package:mymessager/views/Home/ProfileLayout.dart';
import 'package:mymessager/views/Home/SearchLayout.dart';

class HomeController extends RxController {
  RxInt currentTagIndex = 0.obs;
  final searchNameTextEditingController = TextEditingController().obs;
  var listUserfound = <UserModel>[].obs;
  Widget getBody() {
    if (currentTagIndex.value == 0) {
      return GroupMessage();
    }
    if (currentTagIndex.value == 1) {
      return SearchLayout();
    }
    return ProfileLayout();
  }

  onPressedSearchButton() async {
    print("...onPressedSearchButton");
    listUserfound.value = await Database()
        .getUserByName(searchNameTextEditingController.value.text);
    // ignore: invalid_use_of_protected_member
    print(listUserfound.value.length);
  }
}
