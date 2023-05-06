

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/constants.dart';
import 'locationcontrollers.dart';

class OrderController extends GetxController{
  var is_accepting=false.obs;



  // complet order

  var is_correct_code=false.obs;
  var is_completing=false.obs;


  // active order
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    get_marker_icon();
  }

  // order detail status
  BitmapDescriptor pharm_marker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor user_marker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor delivery_marker = BitmapDescriptor.defaultMarker;

  Rx<List<LatLng>> polylinecordinates =Rx<List<LatLng>>([]);

  void getpolyline(Map<String,dynamic> order) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.mapapi,
        PointLatLng(order["pharmacy"]["address"]["latitude"],order["pharmacy"]["address"]["longitude"]),
        PointLatLng(order["order_address"]["latitude"],order["order_address"]["longitude"]));

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylinecordinates.value.add(LatLng(point.latitude, point.longitude));
      }
    }
  }

  get_marker_icon() async {
    //pharma marker
   await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/marker.png")
        .then((value) => pharm_marker = value);
    // user marker
   await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/marker.png")
        .then((value) => user_marker = value);
    // delivery marker
   await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/marker.png")
        .then((value) => delivery_marker = value);

  }



}