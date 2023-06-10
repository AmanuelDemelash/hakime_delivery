import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/controllers/locationcontrollers.dart';
import 'package:hakime_delivery/utils/constants.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/orderconteroller.dart';

class ActiveOrderDetail extends StatelessWidget {
  final int _order_id = Get.arguments;

  ActiveOrderDetail({super.key});

  final Completer<GoogleMapController> _controller = Completer();

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
            icon: const FaIcon(FontAwesomeIcons.angleLeft,color: Colors.white,)),
      ),
      body: SafeArea(
          child: Query(
              options: QueryOptions(
                  document: gql(Myquery.activeorderdetail),
                  variables: {"id": _order_id}),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  print(result.exception.toString());
                }
                if (result.isLoading) {
                  return const Center(
                    child: cool_loding(),
                  );
                }
                Map<String, dynamic> oreder = result.data!["orders_by_pk"];
                return Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                    ),
                       SizedBox(
                         height: Get.height,
                         child: Obx(() {
                            return
                              GoogleMap(
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    Get.find<Locationcontrollers>()
                                        .current_lat
                                        .value,
                                    Get.find<Locationcontrollers>()
                                        .current_long
                                        .value),
                                zoom: 17.4746,
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId("ph"),
                                  position: LatLng(
                                      oreder["pharmacy"]["address"]["latitude"],
                                      oreder["pharmacy"]["address"]["longitude"]),
                                  icon: Get.find<OrderController>().pharm_marker,
                                ),
                                Marker(
                                    markerId: const MarkerId("user"),
                                    position: LatLng(
                                        oreder["order_address"]["latitude"],
                                        oreder["order_address"]["longitude"]),
                                    icon: Get.find<OrderController>().user_marker),
                                Marker(
                                    markerId: const MarkerId("delvery"),
                                    position: LatLng(
                                        Get.find<Locationcontrollers>()
                                            .current_lat
                                            .value,
                                        Get.find<Locationcontrollers>()
                                            .current_long
                                            .value),
                                    icon:
                                        Get.find<OrderController>().delivery_marker)
                              },
                              polylines: {
                                Polyline(
                                    polylineId: const PolylineId("rout"),
                                    color: Constants.primcolor,
                                    width: 7,
                                    points: Get.find<OrderController>()
                                        .polylinecordinates
                                        .value)
                              }
                              ,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                                Get.find<OrderController>().getpolyline(oreder);
                              },
                            );
                          }),
                       ),

                    // face problem
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
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
                                child: oreder["user"]["profile_image"]["url"] ==
                                        null
                                    ? const Text("")
                                    : CachedNetworkImage(
                                        imageUrl: oreder["user"]
                                            ["profile_image"]["url"],
                                        width: 50,
                                        height: 50,
                                        placeholder: (context, url) => Icon(
                                          Icons.image,
                                          color: Constants.whitesmoke
                                              .withOpacity(0.5),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              title: Text(
                                oreder["user"]["full_name"],
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
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
                                      icon: const Icon(Icons.phone,color: Colors.white,),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Constants.primcolor
                                              .withOpacity(0.8),

                                          elevation: 0,
                                          padding: const EdgeInsets.all(15)),
                                      onPressed: () async {
                                        launch(
                                            "tel://${oreder["user"]["phone_number"]}");
                                      },
                                      label: const Text("Call",style: TextStyle(color: Colors.white),),
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
                                      icon: const Icon(Icons.check_circle,color: Colors.white,),
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Colors.red,
                                          padding: const EdgeInsets.all(15)),
                                      onPressed: () {
                                        Get.toNamed("/complate", arguments: {
                                          "id": _order_id,
                                          "phname": oreder["pharmacy"]["name"],
                                          "phloc": oreder["pharmacy"]["address"]
                                              ["location"],
                                          "phimage": oreder["pharmacy"]
                                              ["logo_image"]["url"],
                                          "date": oreder["created_at"],
                                          "dcost": oreder["delivery_fee"],
                                          "tcost": oreder["total_cost"],
                                          "code": oreder["order_code"]
                                        });
                                      },
                                      label: const Text("Delivered",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ),


                  ],
                );
              })),
    );
  }
}
