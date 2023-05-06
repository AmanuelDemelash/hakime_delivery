import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/logincontroller.dart';
import '../../utils/constants.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  var _formkwy = GlobalKey<FormState>();
  TextEditingController _oldpassword = TextEditingController();
  TextEditingController _newpassword = TextEditingController();

  customsnack(String message) {
    return Get.snackbar("Error", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        maxWidth: Get.width,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        padding: const EdgeInsets.all(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Change password",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Constants.primcolor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.key),
                )),
            const SizedBox(height: 10,),
            const Text(
              "Create new password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Your new password must be different from \nprevious used password ",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
                child: Column(
              children: [
                // old password
                Obx(() => TextFormField(
                      controller: _oldpassword,
                      obscureText:
                          Get.find<LoginController>().password_visible.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return customsnack("please enter old  password");
                        } else if (value.length < 6) {
                          return customsnack("Password length must be 6");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          hintText: "old password",
                          filled: true,
                          prefixIcon: const Icon(Icons.key_sharp),
                          suffixIcon: IconButton(
                              onPressed: () {
                                Get.find<LoginController>()
                                        .password_visible
                                        .value =
                                    !Get.find<LoginController>()
                                        .password_visible
                                        .value;
                              },
                              icon: Get.find<LoginController>()
                                          .password_visible
                                          .value ==
                                      true
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black45,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.black45,
                                    )),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.whitesmoke),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primcolor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.primcolor.withOpacity(0.2)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          fillColor: Colors.white),
                    )),
                const SizedBox(
                  height: 10,
                ),
                // new password
                Obx(() => TextFormField(
                      controller: _newpassword,
                      obscureText:
                          Get.find<LoginController>().password_visible.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return customsnack("please enter old  password");
                        } else if (value.length < 6) {
                          return customsnack("Password length must be 6");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          hintText: "old password",
                          filled: true,
                          prefixIcon: const Icon(Icons.key_sharp),
                          suffixIcon: IconButton(
                              onPressed: () {
                                Get.find<LoginController>()
                                        .password_visible
                                        .value =
                                    !Get.find<LoginController>()
                                        .password_visible
                                        .value;
                              },
                              icon: Get.find<LoginController>()
                                          .password_visible
                                          .value ==
                                      true
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black45,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.black45,
                                    )),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.whitesmoke),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primcolor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.primcolor.withOpacity(0.2)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          fillColor: Colors.white),
                    )
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
