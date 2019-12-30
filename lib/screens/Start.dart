import 'dart:convert';

import 'package:greenearth/shared/enumMode.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import 'CircleButton.dart';
import 'Predection.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class EnergyConsumption {
  double value = 0;

  void edit(val) {
    value = val;
  }
}

class _StartState extends State<Start> {
  Position position;
  EnergyConsumption monthlyEnergyConsumption = EnergyConsumption();

  Mode locationMode = Mode.blue;
  Mode energyConsumptionMode = Mode.grey;
  Mode predictMode = Mode.grey;

  Widget locationLoading;
  Widget predictLoading;

  Future<http.Response> getSolarData(String lat, String lon) async {
    String cord = "lat=$lat&lon=$lon";
    print(cord);
    return http.get('https://power.larc.nasa.gov/cgi-bin/v1/DataAccess.py'
            '?request=execute&identifier=SinglePoint&parameters=DIFF,DNR&userCommunity=SSE&'
            'tempAverage=CLIMATOLOGY&outputList=JSON,ASCII&user=anonymous&' +
        cord);
  }

  Widget loading() {
    return LoadingIndicator(
      indicatorType: Indicator.ballScaleMultiple,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Start',
          ),
          /*
          actions: [
            IconButton(
              icon: Icon(Icons.star, color: Colors.white),
              onPressed: () async {
                await Provider.of<AuthService>(context).signOut();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
          */
        ),
        body: Material(
          color: Colors.lightBlue.shade700,
          child: InkWell(
            splashColor: Colors.black38,
            onTap: () {},
            child: Center(
              child: Stack(
                children: <Widget>[
                  CircleButton(
                    alignment: Alignment(1, -1),
                    text: (position == null) ? "1. add location" : position.toString(),
                    radius: 210,
                    mode: locationMode,
                    loading: locationLoading,
                    onTap: () async {
                      setState(() {
                        locationLoading = loading();
                      });
                      Position pos = await Geolocator()
                          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
                      setState(() {
                        locationLoading = null;
                        position = pos;
                        locationMode = Mode.green;
                        energyConsumptionMode = Mode.blue;
                      });
                    },
                  ),
                  CircleButton(
                    alignment: Alignment(-.8, 0.2),
                    text: (monthlyEnergyConsumption.value == 0)
                        ? "2. add energy consumption"
                        : monthlyEnergyConsumption.value.toString() + " kW-hr",
                    radius: 300,
                    mode: energyConsumptionMode,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyDialog(
                            energyConsumption: monthlyEnergyConsumption,
                            text1: 'Enter your monthly energy consumption (kW-hr)',
                          );
                        },
                      );
                      //print(monthlyEnergyConsumption.value);
                      if (monthlyEnergyConsumption.value != 0) {
                        setState(() {
                          energyConsumptionMode = Mode.green;
                          predictMode = Mode.blue;
                        });
                      } else {
                        setState(() {
                          energyConsumptionMode = Mode.blue;
                          predictMode = Mode.grey;
                        });
                      }
                    },
                  ),
                  CircleButton(
                    alignment: Alignment(.95, .95),
                    text: "3. Predict",
                    radius: 160,
                    mode: predictMode,
                    loading: predictLoading,
                    onTap: () async {
                      setState(() {
                        predictLoading = loading();
                      });

                      print("anas");
                      var x = await getSolarData(
                        position.latitude.toString(),
                        position.longitude.toString(),
                      );
                      print("anas2");
                      var data = json.decode(x.body);
                      double diff = data['features'][0]["properties"]["parameter"]["DIFF"]['13'];
                      double dnr = data['features'][0]["properties"]["parameter"]["DNR"]['13'];
                      double dailySunEnergy = dnr + diff;

                      print("anas");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Prediction(
                            monthlyEnergyConsumption: monthlyEnergyConsumption.value,
                            dailySunEnergy: dailySunEnergy,
                            position: position,
                          ),
                        ),
                      );
                      setState(() {
                        predictLoading = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class MyDialog extends StatefulWidget {
  final String text1, text2;
  final EnergyConsumption energyConsumption;

  const MyDialog({Key key, this.text1, this.text2, this.energyConsumption}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController controller;
  FocusNode focusNode;

  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.text2 == '0' ? '' : widget.text2;
    focusNode = FocusNode();
    focusNode.addListener(() {
      //controller.text = ''; // Set new value
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.text1,
      ),
      content: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        focusNode: focusNode,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.done,
          ),
          onPressed: () {
            //submitToFirebase(int.tryParse(controller.text) ?? 0, 'profit');
            //widget.day.profit = double.tryParse(controller.text) ?? 0;
            widget.energyConsumption.edit(double.tryParse(controller.text) ?? 0.0);
            Navigator.pop(context, 1);
          },
        )
      ],
    );
  }

  void submitToFirebase(value, String field) {
    Provider.of<MyDb>(context).setDataToDoc(
      0,
      {field: value},
    );
  }
}
