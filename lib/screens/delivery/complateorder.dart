import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';

import '../../utils/constants.dart';

class ComplateOrder extends StatelessWidget {
   ComplateOrder({super.key});
  var order_data=Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "Complete Order",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Pharmacy"),
                  ),
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl:
                            order_data["phimage"],
                        width: 45,
                        height: 45,
                        placeholder: (context, url) => Icon(
                          Icons.image,
                          color: Constants.primcolor.withOpacity(0.5),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title:  Text(
                      order_data["phname"],
                      style:const TextStyle(),
                    ),
                    subtitle: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Constants.primcolor.withOpacity(0.5),
                          size: 14,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                         Flexible(
                          child: Text(
                            order_data["phloc"],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Order detail"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Order date",
                          style: TextStyle(color: Colors.black54),
                        ),
                       const SizedBox(
                          width: 10,
                        ),
                        Text(order_data["date"].toString().substring(0,9))
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                       const Text(
                          "Total",
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(" ETB ${order_data["dcost"] +order_data["tcost"]}")
                      ],
                    ),
                  )
                ],
              ),
            ),

            // payment option
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Payment detail"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.moneyBill),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Cash on delivery")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Enter Order Code to Complete the Ortder!"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Order Code*"),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Enter order code",
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primcolor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primcolor)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primcolor)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Constants.primcolor))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            // swaip button
            Container(
              margin: const EdgeInsets.all(20),
              child: Center(
                  child: SwipeButton(
                width: Get.width,
                height: 60,
                thumb: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.angleRight,
                    color: Colors.white,
                  ),
                ),
                onSwipeEnd: () {
                  Get.dialog(AlertDialog(
                    title: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: cool_loding(),
                    ),
                  ));
                },
                activeTrackColor: Constants.primcolor.withOpacity(0.7),
                elevationThumb: 10,
                enabled: true,
                child: const Text(
                  "Swipe to complet order",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
