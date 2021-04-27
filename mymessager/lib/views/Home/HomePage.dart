import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymessager/controllers/HomeController/HomeController.dart';
import 'package:mymessager/controllers/UserController/UserController.dart';

class HomePage extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();
  // ignore: unused_field
  final HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text("MyHomeMessage"),
          leading: Container(),
          actions: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.blue[400]),
                onPressed: () async {
                  await _userController.userLogout();
                },
                icon: Icon(Icons.logout),
                label: Text("Logout")),
          ],
        ),
        body: GetX<HomeController>(
          builder: (controller) {
            return controller.getBody();
          },
        ),
        bottomNavigationBar: GetX<HomeController>(builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.currentTagIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_sharp),
                label: "Profile",
              ),
            ],
            onTap: (value) {
              controller.currentTagIndex.value = value;
            },
          );
        }),
      ),
    );
  }
}
