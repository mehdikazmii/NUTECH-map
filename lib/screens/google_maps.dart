// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/location/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:draggable_fab/draggable_fab.dart';

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

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initialization();
    Provider.of<LocationProvider>(context, listen: false).getSourcelocation();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      if (model.locationPosition != null) {
        return Scaffold(
          body: model.locationPosition == null
              ? const Center(child: SpinKitCircle(color: Colors.black))
              : Stack(alignment: Alignment.center, children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: model.locationPosition!,
                      zoom: 13.4746,
                    ),
                    myLocationButtonEnabled: true,
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
                },
                child: const Icon(Icons.center_focus_strong),
              ),
            ),
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
