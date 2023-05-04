import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/utils/constants.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class ActiveOrderDetail extends StatelessWidget {

   final int _order_id=Get.arguments;
  ActiveOrderDetail({super.key});

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(9.005401, 38.763611),
    zoom: 17.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "Navigation",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const FaIcon(FontAwesomeIcons.angleLeft)),
      ),
      body: SafeArea(
        child:
            Query(options: QueryOptions(document: gql(Myquery.activeorderdetail)),
                builder:(result, {fetchMore, refetch}) {
              if(result.hasException){
                print(result.exception.toString());
              }
               if(result.isLoading){
                 return const Center(child: cool_loding(),);
               }
               Map<String,dynamic> oreder=result.data!["orders_by_pk"];
                  return Stack(
                    children: [
                      Obx(() =>
                          GoogleMap(
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            initialCameraPosition: kGooglePlex,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            myLocationButtonEnabled: false,
                            compassEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ))
                      ,
                      // face problem
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child:
                        Container(
                          width: Get.width,
                          height: 60,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Are you facing any trouble?"),
                              Text("Click here",
                                  style: TextStyle(color: Constants.primcolor))
                            ],
                          ),
                        ),
                      ),
                    // user data
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 160,
                            width: Get.width,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Constants.primcolor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(children: [
                              // user info
                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child:oreder["user"]["profile_image"]["url"]==null?const
                                  Text(""): CachedNetworkImage(
                                    imageUrl:
                                    oreder["user"]["profile_image"]["url"],
                                    width: 50,
                                    height: 50,
                                    placeholder: (context, url) =>
                                        Icon(
                                          Icons.image,
                                          color: Constants.whitesmoke
                                              .withOpacity(0.5),
                                        ),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title:Text(
                                  oreder["user"]["full_name"],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle:  Text(
                                  oreder["order_address"]["location"],
                                  style: const TextStyle(color: Colors.white54),
                                ),
                              ),
                              const Divider(
                                color: Colors.white12,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ]),
                          )),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: Get.width,
                            height: 70,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // call
                                Expanded(
                                  child: SizedBox(
                                    width: Get.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ElevatedButton.icon(
                                        icon: const Icon(Icons.phone),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            Constants.primcolor.withOpacity(
                                                0.8),
                                            elevation: 0,
                                            padding: const EdgeInsets.all(15)),
                                        onPressed: () async {
                                          launch("tel://${oreder["user"]["phone_number"]}");
                                        },
                                        label: const Text("Call"),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                // deleverd
                                Expanded(
                                  child: SizedBox(
                                    width: Get.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ElevatedButton.icon(
                                        icon: const Icon(Icons.check_circle),
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.all(15)),
                                        onPressed: () {
                                          Get.toNamed("/complate",arguments:{
                                            "id":_order_id,
                                            "phname":oreder["pharmacy"]["name"],
                                            "phloc":oreder["pharmacy"]["address"]["location"],
                                            "phimage":oreder["pharmacy"]["logo_image"]["url"],
                                            "date":oreder["created_at"],
                                            "dcost":oreder["delivery_fee"],
                                            "tcost":oreder["total_cost"],
                                            "code":oreder["order_code"]
                                          });
                                        },
                                        label: const Text("Delivered"),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  );
                }

              )

      ),
    );
  }
}
