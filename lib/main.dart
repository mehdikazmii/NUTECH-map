// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps/screens/DrawerScreens/about_us.dart';
import 'package:maps/screens/DrawerScreens/bus_routes.dart';
import 'package:maps/screens/DrawerScreens/bus_timetable.dart';
import 'package:maps/screens/DrawerScreens/feedback.dart';
import 'package:maps/screens/DrawerScreens/rector_vision.dart';
import 'package:maps/screens/google_maps.dart';
import 'package:maps/screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location/location_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? bus;
  @override
  void initState() {
    super.initState();
    getData();
    requestPermission(Permission.notification);
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getKeys());
    setState(() {
      if (prefs.getString('Bus') != null) {
        bus = true;
      } else {
        bus = false;
      }
    });
  }

  requestPermission(Permission notification) async {
    if (await Permission.location.isGranted) {
    } else if (await Permission.location.isDenied) {}
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print(statuses[Permission.location]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LocationProvider(),
            child: const MapsGoogle(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: bus != null
              ? bus!
                  ? const MapsGoogle()
                  : const HomeScreen()
              : const CircularProgressIndicator(),
          routes: {
            MapsGoogle.id: (context) => const MapsGoogle(),
            HomeScreen.id: (context) => const HomeScreen(),
            AboutUs.id: (context) => const AboutUs(),
            BusRoute.id: (context) => const BusRoute(),
            BusTimetable.id: (context) => const BusTimetable(),
            FeedbackReport.id: (context) => const FeedbackReport(),
            RectorVision.id: (context) => const RectorVision(),
          },
        ));
  }
}
