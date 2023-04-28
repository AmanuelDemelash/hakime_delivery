import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakime_delivery/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ActiveOrderDetail extends StatelessWidget {
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
        child: Stack(
          children: [
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
            ),
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
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://media.istockphoto.com/id/1325914526/fr/photo/les-pharmaciens-noirs-masculins-et-caucasiens-utilisent-la-tablette-num%C3%A9rique-parlent-de-la.webp?s=2048x2048&w=is&k=20&c=FmBTPcU0wCrUINPi85Ppt1CStgxLjIOlqUBjd8tEQto=",
                          width: 50,
                          height: 50,
                          placeholder: (context, url) => Icon(
                            Icons.image,
                            color: Constants.primcolor.withOpacity(0.5),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text(
                        "Amanuel demelash",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "St.george church,fasile road Bahirdar",
                        style: TextStyle(color: Colors.white54),
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
                                      Constants.primcolor.withOpacity(0.8),
                                  elevation: 0,
                                  padding: const EdgeInsets.all(15)),
                              onPressed: () async {
                                launch("tel://21213123123");
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
                                Get.toNamed("/complate");
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
        ),
      ),
    );
  }
}
