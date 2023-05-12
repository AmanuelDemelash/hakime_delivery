import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/mymutation.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/controllers/homepagecontroller.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/utils/constants.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashbord extends StatelessWidget {
  const Dashbord({super.key});


   double get_completed_percent(List orders){
     int comp_orders=0;
     double percent=0.0;

     orders.forEach((element) {

       if(element["status"]=="delivered"){
         comp_orders=comp_orders+1;
       }
       percent=comp_orders/orders.length *100;
       percent=percent/100;

     });
     return percent;
   }
   int get_active_orders(List orders){
     int activeOrder=0;
     orders.forEach((element) {
       if(element["status"]=="on_delivery"){
         activeOrder=activeOrder+1;
       }
     });
     return activeOrder;
   }
  int get_total_earning(List orders){
    int totalearning=0;
    orders.forEach((element) {
        totalearning= totalearning + int.parse(element["delivery_fee"].toString());
    });
    return totalearning;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Query(
                      options: QueryOptions(
                          document: gql(Myquery.dashbord_profile),
                          variables: {
                            "id":
                                Get.find<SplashController>().prefs.getInt("id")
                          },
                          pollInterval: const Duration(seconds: 10)),
                      builder: (result, {fetchMore, refetch}) {
                        if (result.hasException) {
                          print(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                cool_loding(),
                              ],
                            ),
                          );
                        }
                        Map<String, dynamic> deliveryProfile =
                            result.data!["deliverers_by_pk"];
                        if (deliveryProfile.isNotEmpty) {
                          Get.find<HomePageController>().is_online.value =
                              deliveryProfile["is_online"];
                        }
                        return Column(
                          children: [
                            //header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      deliveryProfile["image"]["url"]),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Welcome",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    ),
                                    Text(
                                      deliveryProfile["full_name"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            //onlin status
                            SizedBox(
                              width: Get.width,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Are you avillable ?",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Mutation(
                                    options: MutationOptions(
                                      document:
                                          gql(Mymutation.update_online_status),
                                    ),
                                    builder: (runMutation, result) {
                                      if (result!.hasException) {
                                        print(result.exception);
                                      }
                                      return Obx(() => Switch.adaptive(
                                            value:
                                                Get.find<HomePageController>()
                                                    .is_online
                                                    .value,
                                            activeColor: Constants.primcolor,
                                            onChanged: (value) {
                                              // run mutation of update online
                                              Get.find<HomePageController>()
                                                  .is_online
                                                  .value = value;
                                              runMutation({
                                                "id":
                                                    Get.find<SplashController>()
                                                        .prefs
                                                        .getInt("id"),
                                                "is_online": value
                                              });

                                            },
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.amber[200]?.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Total order",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                              color: Colors.amber,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.delivery_dining,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${deliveryProfile["orders"]==null?0:deliveryProfile["orders"].length} order",
                                        style:const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Wallet",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.wallet,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                       Text(
                                        "${deliveryProfile["wallet"]?? 0} ETB",
                                        style:const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.pink[200]?.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Active orders",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                              color: Colors.pink,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.local_activity,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${deliveryProfile["orders"]==null?0:get_active_orders(deliveryProfile["orders"])} order",
                                        style:const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Total Earning",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.money,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                       Text(
                                        "${deliveryProfile["orders"]==null?0:get_total_earning(deliveryProfile["orders"]).toString()} ETB",
                                        style:const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            // other data
                            Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:  [
                                     const Text(
                                        "Total Completed orders",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "1/${deliveryProfile["orders"]==null?0:deliveryProfile["orders"].length} completes",
                                        style:const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent:deliveryProfile["orders"]==null?0:get_completed_percent(deliveryProfile["orders"]),
                                      animationDuration: 400,
                                      center:  Text(
                                        "${deliveryProfile["orders"]==null?0.toString():get_completed_percent(deliveryProfile["orders"])*100} %",
                                        style:const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Constants.primcolor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // withdrawals pending
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Withdraw"),
                                  Text("See all")
                                ],
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
                        );
                      }),
                ))));
  }
}
