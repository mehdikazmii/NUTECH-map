// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'direction_model.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio = Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyDyCFHyfwA0N7xdY1GnwYcAUZUonrv_S7o',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      if ((response.data['routes'] as List).isNotEmpty) {
        // print('-----------------------------');
        // print(response.data);
        return Directions.fromMap(response.data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
