
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:permission_handler/permission_handler.dart';

class Front extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ZeroRoute();
  }
}

class ZeroRoute extends State<Front> {
  bool flag1 = false, flag2 = false, flag3 = false;
  @override
  void initState() {
    super.initState();
  }

  void _askPermissioncontact() {
    Permission.contacts.request();
  }

  void _askPermissionsms() {
    Permission.sms.request();
  }

  void _askPermissionlocation() {
    Permission.location.request();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: (flag1 && flag2 && flag3)
              ? Colors.lightBlue[700]
              : Colors.lightBlue[50],
          label: (flag1 && flag2 && flag3) ? Text('Continue') : Text(' '),
          onPressed: () {
            if (flag1 && flag2 && flag3) {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => Login()),
              );
            }
          },
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/images/fronticon.png",
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    'Be Safe',
                    style: TextStyle(
                        color: Colors.lightBlue[900],
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'WELCOME PLEASE GIVE ALL THE PERMISSION TO CONTINUE',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    elevation: 5.0,
                    color: flag3 ? Colors.lightBlue[50] : Colors.lightBlue[200],
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (flag3 == false) {
                        _askPermissionlocation();
                        var status = await Permission.location.status;
                        if (status == PermissionStatus.granted) {
                          setState(() {
                            flag3 = true;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Location',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  RaisedButton(
                    elevation: 5.0,
                    color: flag2 ? Colors.lightBlue[50] : Colors.lightBlue[200],
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (flag2 == false) {
                        _askPermissionsms();
                        var status = await Permission.location.status;
                        if (status == PermissionStatus.granted) {
                          setState(() {
                            flag2 = true;
                          });
                        }
                      }
                    },
                    child: Text(
                      'SMS',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  RaisedButton(
                    elevation: 5.0,
                    color: flag1 ? Colors.lightBlue[50] : Colors.lightBlue[200],
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (flag1 == false) {
                        _askPermissioncontact();
                        var status = await Permission.location.status;
                        if (status == PermissionStatus.granted) {
                          setState(() {
                            flag1 = true;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Contacts',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
