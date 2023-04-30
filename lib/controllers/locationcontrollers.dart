import 'package:get/get.dart';
import 'package:location/location.dart';

class Locationcontrollers extends GetxController {
  late LocationData locationData;
  var current_lat = 0.0.obs;
  var current_long = 0.0.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await Future.delayed(
      Duration(seconds: 5),
      () {
        get_current_location();
      },
    );
  }

  Future<void> get_current_location() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    current_lat.value=locationData.latitude!;
    current_long.value=locationData.latitude!;
    update();
  }
}
