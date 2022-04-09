import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'google_maps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String bus1 = 'Bus 1';
  final String bus2 = 'Bus 2';
  final String bus3 = 'Bus 3';

  void saveData(String bus) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('Bus', bus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262626),
      appBar: AppBar(
        title: const Text('NUTECH  Bus  Tracking'),
        backgroundColor: const Color(0xFF020B13),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, MapsGoogle.id);
                saveData(bus1);
              },
              child: Text(
                bus1,
                style: const TextStyle(color: Color(0xFF400128)),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFDAAB2D),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 65, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MapsGoogle.id);
                  saveData(bus2);
                },
                child: Text(
                  bus2,
                  style: const TextStyle(color: Color(0xFF400128)),
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFDAAB2D),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 65, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MapsGoogle.id);
                saveData(bus3);
              },
              child: Text(
                bus3,
                style: const TextStyle(color: Color(0xFF400128)),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFDAAB2D),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 65, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
