import 'package:get/get.dart';

import '../controllers/connectivity.dart';
import '../controllers/homepagecontroller.dart';
import '../controllers/logincontroller.dart';
import '../controllers/splashcontroller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(LoginController());
    Get.put(HomePageController());
    Get.put(CheekConnecctivityController());
  }
}