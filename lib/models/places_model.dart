import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class Place {
  String description = "",
      id = '',
      email = "",
      phone = "",
      type = "",
      name = "",
      placetype = "",
      image = "";
  //final GeoPoint  a= "",
  double ratings = 0.0;
  List<String> likedby = [];
  LocationData location =
      LocationData.fromMap({'longitude': 24.0, 'latitude': 32.0});
  Place(this.description, this.email, this.likedby, this.name, this.phone,
      this.placetype, this.ratings, this.image, this.location, this.id);
}

class Places {
  List<Place> places = [];

  Places.fromJson(QuerySnapshot snapshot) {
    snapshot.docs.forEach((item) {
      print(item['location'].longitude);
      print(item['description']);
      places.add(Place(
          item['description'],
          item['email'],
          item['likedby'].cast<String>(),
          item['name'],
          item['phone'],
          item['type'],
          item['ratings'],
          item['image'],
          LocationData.fromMap({
            'latitude': item['location'].latitude,
            'longitude': item['location'].longitude
          }),
          item.id));
    });
  }

  // Places.fromMap(Map<String, dynamic> json) {
  //   // json.every((element) element.docs.single.data());

  //   places.add(Place(
  //       json['description'],
  //       json['email'],
  //       json['likedby'].cast<String>(),
  //       json['name'],
  //       json['phone'],
  //       json['type'],
  //       json['ratings'],
  //       json['image']));
  // }
}
