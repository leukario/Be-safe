import 'package:flutter/material.dart';
import 'package:flutter_application_1/Realtappingpage.dart';
import 'package:flutter_application_1/front.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tappingpage.dart';
import 'package:contacts_service/contacts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('is_logged_in');
  String initialroute;
  if (isLoggedIn == null) {
    initialroute = '/';
  } else {
    initialroute = 'tap';
  }

  runApp(MaterialApp(
    initialRoute: initialroute,
    routes: {
      '/': (context) => Front(),
      'tap': (context) => Tapping(),
    },
  ));
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondRoute();
  }
}

class SecondRoute extends State<Login> {
  Iterable<Contact> contactlist = [];
  var selectedContacts = [];
  bool fade = true;
  int count = 0;
  List<bool> taps;
  @override
  void initState() {
    super.initState();
    readContacts();
  }

  readContacts() async {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contactlist = contacts;
    });
    taps = List.filled(contacts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    void add() async {
      int j = 1;
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('count', count);
      for (int i = 0; i < count; i++) {
        final prefs = await SharedPreferences.getInstance();
        String num = selectedContacts.elementAt(i).toString();
        prefs.setString('$j', num);
        j++;
      }

      SharedPreferences prefs2 = await SharedPreferences.getInstance();
      prefs2.setBool('is_logged_in', true);
    }

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text("     Select the Contacts"),
              elevation: 5,
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor:
                  (fade) ? Colors.lightBlue[50] : Colors.lightBlue[700],
              label: (fade) ? Text('  ') : Text('Done'),
              onPressed: () {
                if (fade == false) {
                  add();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => Full()),
                  );
                }
              },
            ),
            body: Container(
              child: (contactlist.length > 0)
                  ? ListView.builder(
                      itemCount: contactlist.length,
                      itemBuilder: (context, index) {
                        Contact contact = contactlist.elementAt(index);
                        var numbers = contact.phones.toList();
                        return Card(
                          child: ListTile(
                            title: Text("${contact.displayName}"),
                            tileColor: taps[index]
                                ? Colors.lightBlue[200]
                                : Colors.lightBlue[50],
                            enabled: count < 5 ? true : false,
                            trailing: InkWell(
                              child: Icon(
                                taps[index]
                                    ? Icons.add_box_rounded
                                    : Icons.add_box_outlined,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                if (count < 5) {
                                  if (taps[index] == false) {
                                    setState(() {
                                      selectedContacts
                                          .add(numbers.elementAt(0).value);
                                      count++;
                                      fade = false;
                                      taps[index] = true;
                                    });
                                  } else {
                                    setState(() {
                                      selectedContacts
                                          .remove(numbers.elementAt(0).value);
                                      count--;
                                      if (count == 0) fade = true;
                                      taps[index] = false;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          Text("Fetching Contacts")
                        ],
                      ),
                    ),
            )));
  }
}
