import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:hakime_delivery/screens/delivery/dashbord.dart';
import 'package:hakime_delivery/screens/delivery/homepage.dart';
import 'package:hakime_delivery/screens/delivery/profile/myprofile.dart';
import '../../../controllers/splashcontroller.dart';
import '../../controllers/homepagecontroller.dart';
import '../../utils/constants.dart';

class MainHomePage extends StatelessWidget {
  MainHomePage({super.key});

  final _pagecontroller = PageController(initialPage: 0);
  Future<void> _onWillPop(BuildContext context) async {
    await showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => exit(0),
            child:
                const Text('Yes', style: TextStyle(color: Constants.primcolor)),
          ),
        ],
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();
    return WillPopScope(
        onWillPop: () async {
          _onWillPop(context);
          return true;
        },
        child: AdvancedDrawer(
          backdropColor: Constants.primcolor,
          controller: Get.find<HomePageController>().advancedDrawerController,
          animationCurve: Curves.bounceIn,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: Drawer(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: ListTile(
                          onTap: () async {
                            await Get.find<SplashController>()
                                .prefs
                                .remove('id');
                            await Get.find<SplashController>()
                                .prefs
                                .remove('token');
                            await Get.find<SplashController>()
                                .prefs
                                .remove('isdoctor');
                            Get.offAllNamed("/login");
                          },
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.yellow,
                          ),
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          child: Scaffold(
              backgroundColor: Constants.whitesmoke,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pagecontroller,
                  children: [const Dashbord(), const Homepage(), Myprofile()],
                ),
              ), //destination screen
              bottomNavigationBar: Obx(() => BottomNavigationBar(
                      currentIndex:
                          Get.find<HomePageController>().current_bnb_item.value,
                      backgroundColor: Constants.primcolor,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.white54,
                      onTap: (value) {
                        Get.find<HomePageController>().current_bnb_item.value =
                            value;
                        _pagecontroller.jumpToPage(value);
                      },
                      elevation: 0,
                      selectedFontSize: 16,
                      items: const [
                        BottomNavigationBarItem(
                            label: "Home", icon: Icon(Icons.home)),
                        BottomNavigationBarItem(
                            label: "Orders",
                            icon: Icon(Icons.delivery_dining_outlined)),
                        BottomNavigationBarItem(
                            label: "Account", icon: Icon(Icons.person)),
                      ]))),
        ));
  }
}
