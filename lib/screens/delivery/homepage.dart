import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';

import '../../utils/constants.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primcolor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Orders",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.white,
                ))
          ],
          bottom: const TabBar(
              unselectedLabelColor: Colors.white54,
              labelColor: Colors.white,
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
              child: Query(options: QueryOptions(document: gql(Myquery.neworder)),
                  builder:(result, {fetchMore, refetch}){
                if(result.hasException){

                }
                if(result.isLoading){
                  return Column(
                    children:const [
                       cool_loding(),
                      Text("Today's order request")
                    ],
                  );
                }
              List orders=result.data!["orders"];
                if(orders.isEmpty){
                  return Column(
                    children:const [
                      cool_loding(),
                      Text("Today's order request")
                    ],
                  );
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
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://media.istockphoto.com/id/1325914526/fr/photo/les-pharmaciens-noirs-masculins-et-caucasiens-utilisent-la-tablette-num%C3%A9rique-parlent-de-la.webp?s=2048x2048&w=is&k=20&c=FmBTPcU0wCrUINPi85Ppt1CStgxLjIOlqUBjd8tEQto=",
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
                                  title: const Text(
                                    "Roda pharmacy plc",
                                    style: TextStyle(),
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
                                      const Flexible(
                                        child: Text(
                                          "St.george church,fasile road Bahirdar",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  "User address",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                const ListTile(
                                  title: Flexible(
                                    child: Text(
                                      "Nok kebele 14,fasile road Bahirdar",
                                      style: TextStyle(color: Colors.black87),
                                    ),
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
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "3/2/2023  4:10PM",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Approx: 3Km",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Row(
                                      children: [
                                        // accept
                                        SizedBox(
                                          width: 120,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    padding:
                                                    const EdgeInsets.all(15)),
                                                onPressed: () {},
                                                child: const Text("Accept")),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),

                                        // reject
                                        SizedBox(
                                          width: 120,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor: Colors.red,
                                                    padding:
                                                    const EdgeInsets.all(15)),
                                                onPressed: () {},
                                                child: const Text("Reject")),
                                          ),
                                        )
                                      ],
                                    )
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

                  }

                )


            ),
          ),
          // active orders
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RefreshIndicator(
              color: Constants.primcolor,
              onRefresh: () async {},
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
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
                                        "https://media.istockphoto.com/id/1325914526/fr/photo/les-pharmaciens-noirs-masculins-et-caucasiens-utilisent-la-tablette-num%C3%A9rique-parlent-de-la.webp?s=2048x2048&w=is&k=20&c=FmBTPcU0wCrUINPi85Ppt1CStgxLjIOlqUBjd8tEQto=",
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
                                title: const Text(
                                  "Roda pharmacy plc",
                                  style: TextStyle(),
                                ),
                                subtitle: const Text(
                                  "St.george church,fasile road Bahirdar",
                                ),
                              ),
                              const Text(
                                "User address",
                                style: TextStyle(color: Colors.black54),
                              ),
                              const ListTile(
                                leading: FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  color: Constants.primcolor,
                                ),
                                title: Text(
                                  "Nok kebele 14,fasile road Bahirdar",
                                  style: TextStyle(color: Colors.black54),
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
                                  const Text(
                                    "Approx: 2 Km",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        Get.toNamed("/activeorderdetail"),
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
            ),
          ),
          //completed
          Container()
        ]),
      ),
    );
  }
}
