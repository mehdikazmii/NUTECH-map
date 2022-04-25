// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("GPS3");

      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value))
            as Map<String, dynamic>;
        print('Mehdi Your data is here');
        print(data);
        print(data['latitude']);
      });
    } catch (e) {
      print('Mehdi your catch errror is here');
      print(e);
    }
  }

// var map = {};
//     var dataa = _firestore.collection('Locations').snapshots();
//     await for (var snapshot in dataa) {
//       for (var data in snapshot.docs) {
//         map = data.data();
//         sourceLocation = LatLng(map['location']['0'], map['location']['1']);
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
