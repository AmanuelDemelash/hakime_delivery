import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/controllers/bankinfocontroller.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/utils/constants.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';
import 'package:shimmer/shimmer.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primcolor,
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Available Balance",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
          child: Query(
              options: QueryOptions(
                  document: gql(Myquery.delivery_wallet),
                  variables: {
                    "id": Get.find<SplashController>().prefs.getInt("id")
                  }),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  print(result.exception.toString());
                }
                if (result.isLoading) {
                  return Column(
                    children: [
                      Container(
                        width: Get.width,
                        height: 250,
                        decoration: const BoxDecoration(
                          color: Constants.primcolor,
                        ),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CircularProgressIndicator(
                              color: Constants.whitesmoke,
                            ),
                            // holder name
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Holder Name",
                                        style: TextStyle(color: Colors.white54),
                                      ),
                                      Shimmer.fromColors(
                                          baseColor: Colors.white,
                                          highlightColor: Colors.grey,
                                          child: const SizedBox(
                                            width: 100,
                                            height: 15,
                                          )
                                      ),
                                    ],
                                  ),
                                ]),
                            const SizedBox(
                              height: 25,
                            ),
                            // deposit and withdraw button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // deposit
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: Colors.white),
                                        onPressed: () {},
                                        child: const Text("Deposit",
                                            style:
                                            TextStyle(color: Colors.black))),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                // cash out
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                            Colors.black.withOpacity(0.4)),
                                        onPressed: () {

                                        },
                                        child: const Text("Withdraw",
                                            style:
                                            TextStyle(color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                Container(
                width: Get.width,
                height: Get.height-250,
                decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                ),
                )


                    ],
                  );
                }

                Map<String, dynamic> delveryWallet =
                    result.data!["deliverers_by_pk"];

                return Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Constants.primcolor,
                      ),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "ETB ${delveryWallet["wallet"]}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                          // holder name
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Holder Name",
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    delveryWallet["bank_info"] == null
                                        ? const Text("")
                                        : const Text(
                                            "Amanuel demelash",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                  ],
                                ),
                              ]),
                          const SizedBox(
                            height: 25,
                          ),
                          // deposit and withdraw button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // deposit
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Colors.white),
                                      onPressed: () {},
                                      child: const Text("Deposit",
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              // cash out
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.4)),
                                      onPressed: () {
                                        delveryWallet["bank_info"] == null
                                            ? Get.toNamed("/bankinformation")
                                            : Get.bottomSheet(BottomSheet(
                                                onClosing: () {},
                                                builder: (context) {
                                                  return Container();
                                                },
                                              ));
                                      },
                                      child: const Text("Withdraw",
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // withdrawals pending
                    Container(
                      width: Get.width,
                      height: Get.height-250,
                      decoration:const BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text("Withdraw"), Text("See all")],
                            ),
                          ),
                          Query(
                            options: QueryOptions(
                                document: gql(Myquery.withdrawal),
                                variables: {
                                  "id":
                                  Get.find<SplashController>().prefs.getInt("id")
                                }),
                            builder: (result, {fetchMore, refetch}) {
                              if (result.isLoading) {
                                return const cool_loding();
                              }
                              List withdraw = result.data!["withdrawals"];
                              if (withdraw.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "No withdrawals yet!",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                );
                              }
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: withdraw.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: Get.width,
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                              );
                            },
                          )
                        ],
                      ),
                    )

                  ],
                );
              })),
    );
  }
}
