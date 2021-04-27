import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/ChatRoomController/ChatRoomController.dart';
import 'package:mymessager/controllers/HomeController/HomeController.dart';
import 'package:mymessager/shareds/CircleAvatarImage.dart';

class SearchLayout extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final ChatRoomController chatRoomController = Get.put(ChatRoomController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.grey,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: Get.find<HomeController>()
                        .searchNameTextEditingController
                        .value,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'user name'),
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () async {
                    await homeController.onPressedSearchButton();
                  },
                ),
              ],
            ),
          ),
          GetX<HomeController>(
            init: HomeController(),
            initState: (_) {},
            builder: (_) {
              return Expanded(
                child: ListView.builder(
                  itemCount:
                      Get.find<HomeController>().listUserfound.value.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Get.find<ChatRoomController>().guest.value =
                            homeController.listUserfound.value[index];
                        await Get.find<ChatRoomController>().initialiseIdRoom();
                        Get.toNamed("/chpage");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey,
                              style: BorderStyle.none),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatarImage(
                              ulrImage: homeController
                                  .listUserfound.value[index].ulrImage,
                            ),
                            Column(
                              children: [
                                Text(
                                    "${homeController.listUserfound.value[index].name}"),
                                Text(
                                    "${homeController.listUserfound.value[index].email}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
