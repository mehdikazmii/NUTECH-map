// ignore_for_file: avoid_print
import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  final Location _location = Location();
  Location get location => _location;
  LatLng? locationPosition;
  bool locationServiceActive = true;
  LatLng? sourceLocation;
  // final _firestore = FirebaseFirestore.instance;
  Map<MarkerId, Marker> markers = {};
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  initialization() async {
    setSourceAndDestinationIcons();
    getUserLocation();
    getSourcelocation();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _location.onLocationChanged.listen((LocationData currentLocation) async {
      locationPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      /// destination marker
      await addMarker(
          LatLng(locationPosition!.latitude, locationPosition!.longitude),
          "destination",
          destinationIcon!);
      print(locationPosition);
      notifyListeners();
    });
  }

  addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  getSourcelocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var check = prefs.getString('Bus');
      DatabaseReference? ref;
      if (check == 'Bus 1') {
        ref = FirebaseDatabase.instance.ref("GPS1");
      } else if (check == 'Bus 2') {
        ref = FirebaseDatabase.instance.ref("GPS2");
      } else if (check == 'Bus 3') {
        ref = FirebaseDatabase.instance.ref("GPS3");
      }
      Stream<DatabaseEvent> stream = ref!.onValue;
      stream.listen((DatabaseEvent event) async {
        Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value))
            as Map<String, dynamic>;
        print(data);
        print(
            'Mehdi data is here yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
        sourceLocation = LatLng(data['latitude'], data['longitude']);
        await addMarker(
            LatLng(sourceLocation!.latitude, sourceLocation!.longitude),
            "source",
            sourceIcon!);
      }).onError((error) => print('Mehdi your error is here find it $error'));
    } catch (e) {
      print('Mehdi your catch errror is here');
      print(e);
    }
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(40, 40)),
            'assets/bus_marker.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(40, 40)),
            'assets/user_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }
}




  // getSourcelocation() async {
  //   var map = {};
  //   var dataa = _firestore.collection('Locations').snapshots();
  //   await for (var snapshot in dataa) {
  //     for (var data in snapshot.docs) {
  //       map = data.data();
  //       sourceLocation = LatLng(map['location']['0'], map['location']['1']);
  //       print(sourceLocation);

  //       //source marker
  //       await addMarker(
  //           LatLng(sourceLocation!.latitude, sourceLocation!.longitude),
  //           "source",
  //           sourceIcon!);
  //     }
  //   }
  // }