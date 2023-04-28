import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';

class Myprofile extends StatelessWidget {
  Myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(children: [
                    CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/images/user.png")
                            as ImageProvider),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Constants.primcolor),
                        child: Center(
                          child: IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.camera,
                                color: Colors.white,
                                size: 13,
                              )),
                        ),
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Amanuel demelash",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "0965342345",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //edit account
            ListTile(
              onTap: () => Get.toNamed("/editprofile"),
              leading: const Icon(Icons.person),
              title: const Text("Edit Account"),
            ),
            //wallet
            ListTile(
              onTap: () => Get.toNamed("/wallet"),
              leading: const FaIcon(FontAwesomeIcons.wallet),
              title: const Text("Wallet"),
            ),
            // bank information
            ListTile(
              onTap: () => Get.toNamed("/bankinformation"),
              leading: const FaIcon(FontAwesomeIcons.bank),
              title: const Text("Bank information"),
            ),
            //nptification
            ListTile(
              onTap: () {
                Get.toNamed("/notification");
              },
              leading: const FaIcon(FontAwesomeIcons.bell),
              title: Text("notification".tr),
            ),
            //lamguage
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.earth),
              title: Text('language'.tr),
              trailing: PopupMenuButton(
                padding: const EdgeInsets.only(left: 40),
                icon: const FaIcon(FontAwesomeIcons.angleRight),
                onSelected: (value) {
                  if (value == 'am') {
                    Get.updateLocale(Locale('am', 'ET'));
                  }
                  if (value == 'en') {
                    Get.updateLocale(Locale('en', 'US'));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'en', child: Text("English")),
                  const PopupMenuItem(value: 'am', child: Text("Amharic")),
                ],
              ),
            ),
            //theme
            ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text("Dark Mode"),
                trailing: Switch.adaptive(
                  value: false,
                  onChanged: (value) {},
                )),
            //help
            const ListTile(
              leading: FaIcon(FontAwesomeIcons.servicestack),
              title: Text("Help center"),
            ),
            ListTile(
              onTap: () async {
                await Get.find<SplashController>().prefs.remove('id');
                await Get.find<SplashController>().prefs.remove('token');
                Get.offAllNamed("/login");
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
