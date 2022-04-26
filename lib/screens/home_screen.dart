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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 270,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home_pic.png"), fit: BoxFit.cover),
            ),
            child: const Center(
                child: Text(
              'NUTECH',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          Column(
            children: [
              Container(
                height: 250,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                // child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 7),
                        height: 3,
                        width: 80,
                        color: Colors.black),
                    const Text(
                      'Select Your Bus',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, MapsGoogle.id);
                          saveData(bus1);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.directions_bus_filled_outlined),
                            Text(
                              bus1,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF115A4A),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 65, vertical: 13),
                            textStyle: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MapsGoogle.id);
                          saveData(bus2);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.directions_bus_filled_outlined),
                            Text(
                              bus2,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF115A4A),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 65, vertical: 13),
                            textStyle: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MapsGoogle.id);
                          saveData(bus3);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.directions_bus_filled_outlined),
                            Text(
                              bus3,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF115A4A),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 65, vertical: 13),
                            textStyle: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              //),
            ],
          )
        ],
      ),
    );
  }
}
