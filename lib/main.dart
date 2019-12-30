import 'dart:convert';
import 'dart:math';

import 'package:greenearth/screens/Home.dart';
import 'package:greenearth/screens/MapLocation.dart';
import 'package:greenearth/screens/Start.dart';
import 'package:greenearth/screens/ProfileInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greenearth/screens/TopProfiles.dart';
import 'services/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  Future<http.Response> getSolarData() {
    String cord = "lat=10.57&lon=-7.58";
    return http.get('https://power.larc.nasa.gov/cgi-bin/v1/DataAccess.py'
            '?request=execute&identifier=SinglePoint&parameters=DIFF,DNR&userCommunity=SSE&'
            'tempAverage=CLIMATOLOGY&outputList=JSON,ASCII&user=anonymous&' +
        cord);
  }

  Future<http.Response> solarData;

  @override
  void initState() {
    super.initState();
    solarData = getSolarData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<http.Response>(
              future: solarData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.body);
                  double diff = data['features'][0]["properties"]["parameter"]["DIFF"]['13'];
                  double dnr = data['features'][0]["properties"]["parameter"]["DNR"]['13'];
                  return Text(
                    diff.toString() + '   ' + dnr.toString(),
                  );
                } else {
                  return Text('loading');
                }
              }),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyDb>.value(value: MyDb()),
        StreamProvider<List<aDay>>.value(value: Collection<aDay>(path: 'mama_days').streamData()),
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
        Provider<AuthService>.value(value: AuthService()),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => Home(),// LoginScreen(),
          'topProfiles': (context) => TopProfiles(),
          'home': (context) => Home(),
          'start': (context) => Start(),
          'mapLocation': (context) => Text('anas'),//MapLocation(),
        },
        theme: ThemeData(
          primaryColor: Colors.blue,
          //primaryColorDark: Colors.blueGrey,
          backgroundColor: Colors.lightBlue.shade700,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
