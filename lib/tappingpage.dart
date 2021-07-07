import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_maintained/sms.dart';
import 'Realtappingpage.dart';

class Full extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstRoute();
  }
}

class FirstRoute extends State<Full> {
  void onTap() async {
    int j = 1;

    final prefs = await SharedPreferences.getInstance();
    int count2 = prefs.getInt('count');

    Location location = new Location();
    LocationData locationdata;
    locationdata = await location.getLocation();
    String loc = locationdata.toString();

    for (int i = 0; i < count2; i++) {
      final prefs = await SharedPreferences.getInstance();
      final state2 = prefs.getString('$j') ?? '';
      String num = state2;
      SmsSender sender = SmsSender();
      SmsMessage message = SmsMessage(num, loc);
      sender.sendSms(message);
    }

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    prefs2.setBool('is_logged_in', false);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.lightBlue[700],
          label: Text('Done'),
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => Tapping()));
          },
        ),
        body: Container(
          child: SizedBox.expand(
            child: RaisedButton(
              color: Colors.black,
              child: Text(
                  "Give it a try by tapping on the black screen and giving the permission then check your sms application and Tap on Done to continue..",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              onPressed: () {
                onTap();
              },
            ),
          ),
        ),
      ),
    );
  }
}
