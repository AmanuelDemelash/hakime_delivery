import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/controllers/notification_controller.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';
import '../../../apiservice/mymutation.dart';
import '../../../controllers/orderconteroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';

class AcceptOrder extends StatelessWidget {
  int order_id;

  AcceptOrder({Key? key, required this.order_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Constants.primcolor,
              padding: const EdgeInsets.all(15)),
          onPressed: () {
            // show dialog
            Get.defaultDialog(
                contentPadding: const EdgeInsets.all(10),
                titlePadding: const EdgeInsets.all(10),
                barrierDismissible: false,
                title: "Are you accepting ?",
                titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                content: const Text(
                  "by accepting this order you will be in-charge to deliver this task ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                actions: [
                  Mutation(
                      options: MutationOptions(
                        document: gql(Mymutation.acceptorder),
                        onError: (error) {
                          Get.back();
                          Constants().customsnackerorr(
                              error!.graphqlErrors.first.message);
                          Get.find<OrderController>().is_accepting.value =
                              false;
                        },
                        onCompleted: (data) {
                          if (data!.isNotEmpty) {
                            Get.back();
                            Constants()
                                .customsnacksuccs('you accepted the order ');
                            Get.find<OrderController>().is_accepting.value =
                                false;

                            Get.toNamed("/activeorderdetail",arguments: order_id);
                            Get.find<NotificationController>().crateNotification("task accepted", "you successfully accepted task to deliver");
                          } else {}
                        },
                      ),
                      builder: (runMutation, result) {
                        if (result!.hasException) {
                          Get.find<OrderController>().is_accepting.value =
                              false;
                          Get.back();
                        }

                        if (result!.isLoading) {
                          Get.find<OrderController>().is_accepting.value = true;
                        }
                        return Get.find<OrderController>().is_accepting.value ==
                                true
                            ? const cool_loding()
                            : TextButton(
                                onPressed: () {
                                  runMutation({
                                    "deliverer_id": Get.find<SplashController>()
                                        .prefs
                                        .getInt("id"),
                                    "order_id": order_id
                                  });
                                },
                                child: const Text(
                                  "Okay Accept",
                                  style: TextStyle(
                                      color: Constants.primcolor,
                                      fontWeight: FontWeight.bold),
                                ));
                      })
                ]);
          },
          child: const Text("Accept")),
    );
  }
}

