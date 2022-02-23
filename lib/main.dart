import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps/screens/google_maps.dart';
import 'package:maps/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'location/location_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          initialRoute: HomeScreen.id,
          routes: {
            MapsGoogle.id: (context) => const MapsGoogle(),
            HomeScreen.id: (context) => const HomeScreen(),
          },
        ));
  }
}
