import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:logo/constants/firebase.dart';
import 'package:logo/models/places_model.dart';
import 'package:logo/views/pages/first_page.dart';
import 'package:location/location.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  RxList<Place> places = <Place>[].obs;
  RxList<Place> placessearch = <Place>[].obs;

  late Rx<LocationData> preciselocation =
      LocationData.fromMap({'longitude': 24.0, 'latitude': 32.0}).obs;
  RxDouble distance = 0.0.obs;
  final TextEditingController search = TextEditingController();
  RxString controllerText = ''.obs;
  RxList<Place> nearplaces = <Place>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    _initializePlacesModel();
    //places.bindStream(abc());
    // places.bindStream(streamPlaces());
    search.addListener(() {
      controllerText.value = search.text;
      // _searchPlaces(controllerText.value);
    });
    // debounce(controllerText, (_) {
    //   print("debouce$_");
    // }, time: Duration(seconds: 1));
    preciselocation.value = await getLocation();
    distance.value = distancefunc();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    instance.dispose();
  }

  distancefunc() {
    var distance = calculateDistance(preciselocation.value.latitude,
        preciselocation.value.longitude, 33.68799951358828, 73.0315706838622);
    // print("distance====================" + distance.toString());
    return distance;
  }

  _initializePlacesModel() async {
    QuerySnapshot temp = await firebaseFirestore.collection("places").get();
    var p1 = Places.fromJson(temp);
    places.value = p1.places;
  }

  searchPlaces() async {
    var temp = await firebaseFirestore
        .collection("places")
        .where('name', isGreaterThanOrEqualTo: controllerText.value)
        .get();
    var p = Places.fromJson(temp);
    places.value = p.places;
  }

  getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
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

    _locationData = await location.getLocation();
    preciselocation.value = _locationData;
    preciselocation.value = await location.onLocationChanged.first;

    print(_locationData);
    return _locationData;
  }

  filter(String type) async {
    var temp = await firebaseFirestore
        .collection("places")
        .where('type', isEqualTo: type)
        .get();
    var p = Places.fromJson(temp);
    places.value = p.places;
  }

  List<Place> nearby() {
    return places
        .where((p) => (calculateDistance(
                p.location.latitude,
                p.location.longitude,
                preciselocation.value.latitude,
                preciselocation.value.longitude) <
            1.0))
        .toList();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    print(
        "Distance===============================================================" +
            (12742 * asin(sqrt(a))).toString());
    return 12742 * asin(sqrt(a));
  }
}
