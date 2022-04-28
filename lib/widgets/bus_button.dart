import 'package:flutter/material.dart';
import 'package:maps/screens/google_maps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusButton extends StatefulWidget {
  const BusButton({Key? key, required this.bus}) : super(key: key);

  final String bus;

  @override
  State<BusButton> createState() => _BusButtonState();
}

class _BusButtonState extends State<BusButton> {
  void saveData(String bus) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('Bus', bus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, MapsGoogle.id);
        saveData(widget.bus);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        height: 45,
        width: 230,
        decoration: BoxDecoration(
            color: const Color(0xFF115A4A),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_bus_filled_outlined,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.bus,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
