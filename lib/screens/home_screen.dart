import 'dart:core';
import 'package:flutter/material.dart';
import 'package:maps/widgets/bus_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 350,
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
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 330,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  // child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(top: 7),
                        height: 3,
                        width: 80,
                      ),
                      const SizedBox(height: 100),
                      const Text(
                        'Select Your Bus',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 50),
                      BusButton(bus: bus1),
                      BusButton(bus: bus2),
                      BusButton(bus: bus3)
                    ],
                  ),
                ),
                //),
              ],
            ),
          )
        ],
      ),
    );
  }
}
