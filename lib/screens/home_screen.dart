import 'dart:core';
import 'package:flutter/material.dart';

import 'google_maps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              onPressed: () {
                Navigator.pushNamed(context, MapsGoogle.id);
              },
              child: const Text(
                'Bus 1',
                style: TextStyle(color: Color(0xFF400128)),
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
                },
                child: const Text(
                  'Bus 2',
                  style: TextStyle(color: Color(0xFF400128)),
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
              },
              child: const Text(
                'Bus 3',
                style: TextStyle(color: Color(0xFF400128)),
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
