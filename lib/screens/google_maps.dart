// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/location/location_provider.dart';
import 'package:maps/main.dart';
import 'package:maps/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapsGoogle extends StatefulWidget {
  static String id = 'MapsGoogle';

  const MapsGoogle({Key? key}) : super(key: key);
  @override
  _MapsGoogleState createState() => _MapsGoogleState();
}

class _MapsGoogleState extends State<MapsGoogle> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController googleMapController;
  LocationProvider location = LocationProvider();
  String bus = 'Bus';
  @override
  void initState() {
    super.initState();
    setState(() {
      Provider.of<LocationProvider>(context, listen: false).initialization();
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                //channel.description,
                icon: android.smallIcon,
                playSound: true,
                color: Colors.blue,
                // other properties...
              ),
            ));

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print('A new onMessageOpenedApp event was Published');
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(notification.title!),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(notification.body!)],
                      ),
                    ),
                  );
                });
          }
        });
      }
    });
    getData();
  }

  delay() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bus = prefs.getString('Bus')!;
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    double distance;
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));
    niotification(distance);
    return distance;
  }

  niotification(double distance) async {
    if (distance <= 2) {
      await Future.delayed(const Duration(minutes: 4));
    }
  }

  navigate() {
    Navigator.pushNamed(context, HomeScreen.id);
    remove();
  }

  remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('Bus');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider?>(
        builder: (consumerContext, model, child) {
      return Scaffold(
        body: model!.locationPosition == null && model.sourceLocation == null
            ? const Center(child: SpinKitCircle(color: Colors.black))
            : Stack(alignment: Alignment.center, children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: model.locationPosition!,
                    zoom: 13.4746,
                  ),
                  myLocationButtonEnabled: false,
                  markers: Set<Marker>.of(model.markers.values),
                  //polylines: Set<Polyline>.of(polylines.values),
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controllerGoogleMap.complete(controller);
                    googleMapController = controller;
                  },
                ),
                Positioned(
                  bottom: 20.0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      'Bus Distance :  ' +
                          calculateDistance(
                            model.markers.values
                                .singleWhere((element) =>
                                    element.markerId ==
                                    const MarkerId("destination"))
                                .position
                                .latitude,
                            model.markers.values
                                .singleWhere((element) =>
                                    element.markerId ==
                                    const MarkerId("destination"))
                                .position
                                .longitude,
                            model.markers.values
                                .singleWhere((element) =>
                                    element.markerId ==
                                    const MarkerId("source"))
                                .position
                                .latitude,
                            model.markers.values
                                .singleWhere((element) =>
                                    element.markerId ==
                                    const MarkerId("source"))
                                .position
                                .longitude,
                          ).toInt().toString() +
                          '  km',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 20,
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        bus,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: navigate,
                  ),
                ),
              ]),
        floatingActionButton: DraggableFab(
          child: Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: FloatingActionButton(
              onPressed: () {
                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(model.locationPosition!.latitude,
                      model.locationPosition!.longitude),
                  zoom: 15.4746,
                )));
                flutterLocalNotificationsPlugin.show(
                    0,
                    "Testing",
                    "How you doin ?",
                    NotificationDetails(
                        android: AndroidNotificationDetails(
                            channel.id, channel.name,
                            importance: Importance.high,
                            color: Colors.blue,
                            playSound: true,
                            icon: '@mipmap/ic_launcher')));
              },
              child: const Icon(Icons.center_focus_strong),
            ),
          ),
        ),
      );

      // return const Center(child: CircularProgressIndicator());
    });
  }
}
