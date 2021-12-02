import 'package:flutter/material.dart';
import 'package:sgmbooking/screens/blank_page.dart';
import 'package:sgmbooking/screens/booking_list.dart';
import 'package:sgmbooking/screens/pasaggeList.dart';
import 'package:sgmbooking/screens/PassaggeDetail.dart';
import 'package:sgmbooking/screens/login.dart';
import 'package:sgmbooking/service/next_screen.dart';

Widget appDrawer(BuildContext context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Column(children: <Widget>[
            Text(
              'SGM',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            new Image.asset(
              'assets/images/GreenBus.png',
              width: 80,
              height: 80.0,
            ),
          ]),
          /*child: 
          Text(
            'SGM',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),*/
        ),
        ListTile(
          title: const Text('Viajes Disponibles'),
          onTap: () {
            Navigator.pop(context);
            nextScreeniOSReplace(context, BookingList());
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Viajes Agendados'),
          onTap: () {
            Navigator.pop(context);
            nextScreeniOSReplace(context, PassageList());

            // Update the state of the app.
            // ...
          },
        ),
        /*ListTile(
          title: const Text('Template'),
          onTap: () {
            Navigator.pop(context);
            nextScreeniOSReplace(context, BlankPage());
            // Update the state of the app.
            // ...
          },
        ),*/
        ListTile(
          title: const Text('Salir'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BlankPage()));
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}
