import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_maintained/sms.dart';

import 'main.dart';

class Tapping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MiddleRoute();
  }
}

class MiddleRoute extends State<Tapping> {
  @override
  Widget build(BuildContext context) {
    void onTap() async {
      int j = 1;
      final prefs = await SharedPreferences.getInstance();
      int count = prefs.getInt('count');

      Location location = new Location();
      LocationData locationdata;
      locationdata = await location.getLocation();
      String loc = locationdata.toString();

      for (int i = 0; i < count; i++) {
        final prefs = await SharedPreferences.getInstance();
        final state2 = prefs.getString('$j') ?? '';
        String num = state2;
        SmsSender sender = SmsSender();
        SmsMessage message = SmsMessage(num, loc);
        sender.sendSms(message);
      }
    }

    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
        body: Container(
          color: Colors.black,
          child: SizedBox.expand(
            child: GestureDetector(
              onDoubleTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
