// ignore_for_file: avoid_print

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  final Location _location = Location();
  Location get location => _location;
  LatLng? locationPosition;
  bool locationServiceActive = true;
  LatLng? sourceLocation;
  final _firestore = FirebaseFirestore.instance;
  Map<MarkerId, Marker> markers = {};
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  initialization() async {
    await getUserLocation();
    setSourceAndDestinationIcons();
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
    _location.onLocationChanged.listen((LocationData currentLocation) {
      locationPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      /// destination marker
      addMarker(LatLng(locationPosition!.latitude, locationPosition!.longitude),
          "destination", destinationIcon!);
      //print(locationPosition);
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
    var map = {};
    var dataa = _firestore.collection('Locations').snapshots();
    await for (var snapshot in dataa) {
      for (var data in snapshot.docs) {
        map = data.data();
        sourceLocation = LatLng(map['location']['0'], map['location']['1']);
        //print(sourceLocation);

        //source marker
        addMarker(LatLng(sourceLocation!.latitude, sourceLocation!.longitude),
            "source", sourceIcon!);
      }
    }
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(40, 40)),
            'assets/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(40, 40)), 'assets/user.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }
}
