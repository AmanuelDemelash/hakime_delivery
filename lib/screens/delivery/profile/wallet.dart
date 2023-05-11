import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/utils/constants.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';


import '../widget/withdraw.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return const Center(child: cool_loding());

                }
                Map<String, dynamic> delveryWallet =result.data!["deliverers_by_pk"];

                return Column(
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: Constants.primcolor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                      ),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
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
                                    // delveryWallet["bank_info"] == null
                                    //     ? const Text("")
                                    //     : const Text(
                                    //         "Amanuel demelash",
                                    //         style:
                                    //             TextStyle(color: Colors.white),
                                    //       )
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
                                      onPressed: () {
                                        Get.toNamed("/deposit");
                                      },
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
                                        // delveryWallet["bank_info"] == null
                                        //     ? Get.toNamed("/bankinformation")
                                        //     :
                                        Get.bottomSheet(
                                            Withdraw(wallet:delveryWallet["wallet"] ,)
                                        );
                                      },
                                      child: const Text("Withdraw",
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height:15,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // withdrawals pending
                    SizedBox(
                      width: Get.width,

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
                                          children: [
                                            Text(
                                              withdraw[index]["created_at"].toString(),
                                              style:const TextStyle(color: Colors.black54),
                                            ),
                                            Text(withdraw[index]["amount"].toString())
                                          ],
                                        ),
                                       withdraw[index]["status"]=="pending" ?const Text(
                                          "pending",
                                          style: TextStyle(color: Colors.red),
                                        ):const Text(
                                         "Confirmed",
                                         style: TextStyle(color: Colors.green),
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
