import 'package:flutter/material.dart';
import 'package:maps/screens/google_maps.dart';
import 'package:maps/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool bus = false;
  @override
  void initState() {
    super.initState();
    getData();
    requestPermission(Permission.notification);
    navigate();
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

  navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    bus
        ? Navigator.pushNamed(context, MapsGoogle.id)
        : Navigator.pushNamed(context, HomeScreen.id);
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
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image(image: AssetImage('assets/Splashscreen_logo.png')),
        ));
  }
}
