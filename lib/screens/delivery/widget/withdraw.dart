import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/mymutation.dart';
import 'package:hakime_delivery/controllers/bankinfocontroller.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/widgets/buttonspinner.dart';

import '../../../utils/constants.dart';

class Withdraw extends StatelessWidget {
  int wallet;

  Withdraw({Key? key, required this.wallet}) : super(key: key);
  TextEditingController amountcont = TextEditingController();

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
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      child: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Please enter the amount "),
                  const Text(
                    "to withdraw from your wallet ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
                        hintText: "amount",
                        filled: true,
                        contentPadding: const EdgeInsets.all(20),
                        prefixIcon: const Icon(Icons.monetization_on_sharp),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.whitesmoke),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primcolor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.primcolor.withOpacity(0.2)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.white),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      width: Get.width,
                      height: 55,
                      child: Mutation(
                          options: MutationOptions(
                            document: gql(Mymutation.withdraw),
                            onCompleted: (data) {
                              if (data!.isNotEmpty) {
                                Get.find<BankinfoController>()
                                    .is_withdraw
                                    .value = false;
                                Get.back();
                              }
                            },
                            onError: (error) {
                              customsnack(error!.graphqlErrors.first.message
                                  .toString());
                              Get.find<BankinfoController>().is_withdraw.value =
                                  false;
                            },
                          ),
                          builder: (runMutation, result) {
                            if (result!.isLoading) {
                              Get.find<BankinfoController>().is_withdraw.value =
                                  true;
                            }
                            return Obx(() => ElevatedButton(
                                onPressed: () {
                                  if (amountcont.text.isEmpty) {
                                    customsnack(
                                        "please add the amount you want to withdrew");
                                  } else if (wallet <
                                      int.parse(amountcont.text)) {
                                    customsnack("you don't have enough money");
                                  } else {
                                    // run mutation
                                    runMutation({
                                      "id": Get.find<SplashController>()
                                          .prefs
                                          .getInt("id"),
                                      "amount": int.parse(amountcont.text)
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(),
                                child: Get.find<BankinfoController>()
                                            .is_withdraw
                                            .value ==
                                        true
                                    ? const ButtonSpinner()
                                    : const Text(
                                        "withdraw",
                                        style: TextStyle(color: Colors.white),
                                      )));
                          }))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
