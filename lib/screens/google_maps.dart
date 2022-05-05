// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/constants.dart';
import 'package:maps/location/location_provider.dart';
import 'package:maps/screens/home_screen.dart';
import 'package:maps/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
  String formattedTime = DateFormat.Hms().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initialization();
    getData();
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
    return distance;
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
                  padding: const EdgeInsets.only(
                    top: 90,
                  ),

                  initialCameraPosition: CameraPosition(
                    target: model.locationPosition!,
                    zoom: 13.4746,
                  ),
                  myLocationButtonEnabled: false,
                  markers: Set<Marker>.of(model.markers!.values),
                  //polylines: Set<Polyline>.of(polylines.values),
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.directions_bus_outlined,
                              color: Color(0xFF115A4A),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              bus,
                              style: const TextStyle(
                                  color: Color(0xFF115A4A),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.route_outlined,
                              color: Color(0xFF115A4A),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              model.markers!.values.isNotEmpty
                                  ? 'Bus Distance :  ' +
                                      calculateDistance(
                                        model.markers!.values
                                            .singleWhere(
                                                (element) =>
                                                    element.markerId ==
                                                    const MarkerId(
                                                        "destination"),
                                                orElse: () => const Marker(
                                                      markerId:
                                                          MarkerId('null'),
                                                    ))
                                            .position
                                            .latitude,
                                        model.markers!.values
                                            .singleWhere(
                                                (element) =>
                                                    element.markerId ==
                                                    const MarkerId(
                                                        "destination"),
                                                orElse: () => const Marker(
                                                      markerId:
                                                          MarkerId('null'),
                                                    ))
                                            .position
                                            .longitude,
                                        model.markers!.values
                                            .singleWhere(
                                                (element) =>
                                                    element.markerId ==
                                                    const MarkerId("source"),
                                                orElse: () => const Marker(
                                                      markerId:
                                                          MarkerId('null'),
                                                    ))
                                            .position
                                            .latitude,
                                        model.markers!.values
                                            .singleWhere(
                                                (element) =>
                                                    element.markerId ==
                                                    const MarkerId("source"),
                                                orElse: () => const Marker(
                                                      markerId:
                                                          MarkerId('null'),
                                                    ))
                                            .position
                                            .longitude,
                                      ).toInt().toString() +
                                      '  km'
                                  : 'Calculating',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF115A4A)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              color: Color(0xFF115A4A),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Time : ' + formattedTime.toString(),
                              style: const TextStyle(
                                  color: Color(0xFF115A4A),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 15,
                  child: GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Icon(Icons.arrow_back, color: kColor)),
                    onTap: navigate,
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 180,
                  child: GestureDetector(
                    onTap: () {
                      googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: model.locationPosition!,
                        zoom: 15.4746,
                      )));
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(
                        Icons.person,
                        color: kColor,
                      ),
                    ),
                  ),
                ),
              ]),
        floatingActionButton:
            // DraggableFab(
            //   child:
            Container(
          margin: const EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.white,
            tooltip: ('Track your Bus'),
            onPressed: () {
              googleMapController
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: model.sourceLocation!,
                zoom: 15.4746,
              )));
            },
            child: Icon(
              Icons.directions_bus_outlined,
              color: kColor,
            ),
          ),
        ),
      );
    });
  }
}
