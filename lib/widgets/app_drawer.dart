import 'package:flutter/material.dart';
import 'package:maps/constants.dart';
import 'package:maps/screens/DrawerScreens/about_us.dart';
import 'package:maps/screens/DrawerScreens/bus_routes.dart';
import 'package:maps/screens/DrawerScreens/bus_timetable.dart';
import 'package:maps/screens/DrawerScreens/feedback.dart';
import 'package:maps/screens/DrawerScreens/rector_vision.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List _drawerMenu = [
      {
        "icon": Icons.info,
        "text": "About us",
        "route": AboutUs.id,
      },
      {"icon": Icons.route, "text": "Bus Route", "route": BusRoute.id},
      {
        "icon": Icons.schedule,
        "text": "Bus TimeTable",
        "route": BusTimetable.id,
      },
      {
        "icon": Icons.feedback_outlined,
        "text": "Feedback/Report",
        "route": FeedbackReport.id,
      },
      {
        "icon": Icons.description_outlined,
        "text": "Rector Vision",
        "route": RectorVision.id,
      },
    ];
    return Container(
      decoration: BoxDecoration(
          color: kColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30))),
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width * 0.2),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              height: 190.0,
              color: kColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.white,
                    foregroundImage: AssetImage('assets/user.png'),
                    //  NetworkImage(
                    //     "https://www.google.com/search?q=profile+image&rlz=1C1BNSD_enPK948PK948&tbm=isch&source=iu&ictx=1&fir=B3G4vEo9lSBh0M%252CFvQHUVZ-cx81xM%252C_%253BH6pHpB03ZEAgeM%252Cwg0CyFWNfK7o5M%252C_%253BTUPxmKQ-sparcM%252CFvQHUVZ-cx81xM%252C_%253Bc4DKZX1IkCpVhM%252Cb5C9ViMmmhpq-M%252C_%253BifTSkpz9J2bh_M%252CurvXhMiZrB4IuM%252C_%253BeHQKa74ZnnpTfM%252C4XfudSI_3wLzPM%252C_%253ByRz0asXqc1iKxM%252Cb5C9ViMmmhpq-M%252C_%253BS2NNOWEtx4Sh8M%252CWIYPytbMl_8XfM%252C_%253B-h20Jdis7Qx6mM%252CwxS10_IL7Dpp9M%252C_%253BJpaFCmffhUdABM%252CeirPelkp9eoYkM%252C_%253BC7pA_LYt9qMKyM%252CMG0JGB0B8kPXNM%252C_%253B2DnrLk3Tlyfo4M%252C8eDeiABW8CreFM%252C_%253Blcjtk8drNcGL8M%252COgWk3wP_2xVHMM%252C_%253Bfzm-cB-sF1nIvM%252C4XfudSI_3wLzPM%252C_%253BWgJP1HLvsHDWSM%252C-_VDyVVleiKWeM%252C_%253BXVWcKFwzJq264M%252CFvQHUVZ-cx81xM%252C_&vet=1&usg=AI4_-kRQZaW9Ubn_p-A_vdJl88LIA7BAdg&sa=X&ved=2ahUKEwiei-_Y4or0AhXEy6QKHefjDyYQ9QF6BAgREAE#imgrc=ifTSkpz9J2bh_M"),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Basit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(Profile.profile);
                        },
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const Text(
                    "basit@technust.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30))),
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: ListView(
                  children: _drawerMenu.map((menu) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(menu["route"]);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Icon(
                            menu["icon"],
                            color: Color(0xFF115A4A),
                          ),
                          title: Text(
                            menu["text"],
                            style: const TextStyle(
                              color: Color(0xFF115A4A),
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
