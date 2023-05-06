
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants.dart';

class Withdraw extends StatelessWidget {
   Withdraw({Key? key}) : super(key: key);

  TextEditingController amountcont=TextEditingController();
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Withdraw from your wallet "),
              TextFormField(
                controller: amountcont,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == "") {
                     customsnack("please enter the amount");
                  } else {
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "email",
                    filled: true,
                    contentPadding: const EdgeInsets.all(20),
                    prefixIcon: const Icon(Icons.email),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius:
                        BorderRadius.all(Radius.circular(15))),
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
                            color:
                            Constants.primcolor.withOpacity(0.2)),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30))),
                    fillColor: Colors.white),
              )
              // amount

            ],
          );
        },
      ),
    );
  }
}
