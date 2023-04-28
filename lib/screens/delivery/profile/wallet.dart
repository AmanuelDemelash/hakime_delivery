import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hakime_delivery/utils/constants.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "My Wallet",
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Constants.primcolor),
                ),
                Expanded(
                  child: Container(
                    width: Get.width,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [
                          Constants.primcolor,
                          Constants.primcolor.withOpacity(0.5)
                        ])),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: 150,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(colors: [
                                Constants.primcolor,
                                Constants.primcolor.withOpacity(0.5)
                              ])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.wallet,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Avaliable Balance",
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "ETB 4000",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(
                              left: 30, top: 5, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Holder Name",
                                style: TextStyle(color: Colors.white54),
                              ),
                              Text(
                                "Amanuel demelash",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 10,
                  height: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      color: Constants.primcolor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // withdrawals pending
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text("Withdraw"), Text("See all")],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "2/3/2023",
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text("400 ETB")
                        ],
                      ),
                      const Text(
                        "pending",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
