import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/cool_loading.dart';

class Constants {
  static const String app_name = "Hakime Delivery";
  static const Color primcolor = Color(0xfff065f46);
  static const Color whitesmoke = Color(0xffff4f4f4);


  // loading dialog


    customsnackerorr(String message) {
      return Get.snackbar("Error", message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          maxWidth: Get.width,
          snackStyle: SnackStyle.GROUNDED,
          margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
          padding: const EdgeInsets.all(10));

  }
  customsnacksuccs(String message) {
    return Get.snackbar("successful", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        maxWidth: Get.width,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        padding: const EdgeInsets.all(10));

  }
}

// Color(0xFFF2d71fd)00663d
//0xFFF047857 prim color other choice
