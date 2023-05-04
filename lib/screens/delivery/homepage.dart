import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/apiservice/subscriptions.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/screens/delivery/widget/acceptorder.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';

import '../../controllers/notification_controller.dart';
import '../../utils/constants.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Orders",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                ))
          ],
          bottom: const TabBar(
              unselectedLabelColor: Colors.black54,
              labelColor: Colors.black,
              indicatorColor: Constants.primcolor,

              tabs: [
                Tab(
                  text: "New Order",
                ),
                Tab(
                  text: "Active Orders",
                ),
                Tab(
                  text: "Completed ",
                )
              ]),
        ),
        body: TabBarView(children: [
          //new orders
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RefreshIndicator(
              color: Constants.primcolor,
              onRefresh: () async {},
              child: Subscription(options: SubscriptionOptions(document: gql(MySubscription.neworders)),
                  builder:(result, {fetchMore, refetch}){
                if(result.hasException){

                }
                if(result.isLoading){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                       cool_loding(),
                      Text("Today's order request")
                    ],
                  );
                }
              List orders=result.data!["orders"];
                if(orders.isEmpty){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      cool_loding(),
                      Text("Today's order request")
                    ],
                  );
                }
                else{
                  Get.find<NotificationController>().play_sound();
                }

                return  ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount:orders.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Container(
                              width: Get.width,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Pharmacy address",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  ListTile(
                                    leading:
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: CachedNetworkImage(
                                        imageUrl:orders[index]["pharmacy"]["logo_image"]["url"]  ,
                                        width: 45,
                                        height: 45,
                                        placeholder: (context, url) => Icon(
                                          Icons.image,
                                          color:
                                          Constants.primcolor.withOpacity(0.5),
                                        ),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title:Text(
                                      orders[index]["pharmacy"]["name"],
                                      style:const TextStyle(),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.locationDot,
                                          color:
                                          Constants.primcolor.withOpacity(0.5),
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            orders[index]["pharmacy"]["address"]["location"],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    "User address",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.locationDot,
                                          color:
                                          Constants.primcolor.withOpacity(0.5),
                                          size: 14,
                                        ),
                                        const SizedBox(width: 10,),
                                        Flexible(
                                          child: Text(
                                            orders[index]["order_address"]["location"],
                                            style:const TextStyle(color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  const Text(
                                    "Order date",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children:[
                                      const FaIcon(
                                        FontAwesomeIcons.clock,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        orders[index]["created_at"].toString().substring(0,9),
                                        style:const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height:4,
                                  ),
                                  // distance and fee
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Approx: ${orders[index]["distance"]}Km",
                                            style:const TextStyle(color: Colors.black54),
                                          ),
                                          Text(
                                            "ETB: ${orders[index]["delivery_fee"]}",
                                            style:const TextStyle(color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width:50,),

                                      // accept
                                      Expanded(
                                          child:AcceptOrder(order_id: orders[index]["id"],)

                                         

                    ),


                                      const SizedBox(
                                        width: 6,
                                      ),



                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                        },
    );

                  },
                )

    )
    ),

          // active orders
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child:
                Query(options: QueryOptions(document: gql(Myquery.activeorder),
                variables: {
                  "id":Get.find<SplashController>().prefs.getInt("id")
                }
                ),
                    builder: (result, {fetchMore, refetch}) {
                  if(result.hasException){
                    return const Center(child: cool_loding(),);
                  }
                  if(result.isLoading){
                    return const Center(child: cool_loding(),);
                  }
                 List? orders=result.data!["orders"];
                  if(orders!.isEmpty){
                    return Center(child: Text("no active order found!"));
                  }

                  return  RefreshIndicator(
                    color: Constants.primcolor,
                    onRefresh: () async {},
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount:orders.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: Container(
                                width: Get.width,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Pharmacy address",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          orders[index]["pharmacy"]["logo_image"]["url"],
                                          width: 40,
                                          height: 40,
                                          placeholder: (context, url) => Icon(
                                            Icons.image,
                                            color:
                                            Constants.primcolor.withOpacity(0.5),
                                          ),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title:  Text(
                                        orders[index]["pharmacy"]["name"],
                                        style: const TextStyle(),
                                      ),
                                      subtitle:  Text(
                                        orders[index]["pharmacy"]["address"]["location"],
                                      ),
                                    ),
                                    const Text(
                                      "User address",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                ListTile(
                                      leading:const FaIcon(
                                        FontAwesomeIcons.locationDot,
                                        color: Constants.primcolor,
                                      ),
                                      title: Text(
                                          orders[index]["order_address"]["location"],
                                        style:const TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                         Text(
                                          "Approx: ${orders[index]["distance"]} Km",
                                          style:const TextStyle(color: Colors.black54),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              Get.toNamed("/activeorderdetail",arguments:orders[index]["id"]),
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: Constants.primcolor,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.angleRight,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                    },)

          ),
          //completed
          Container()
        ]),
      ),
    );
  }
}
