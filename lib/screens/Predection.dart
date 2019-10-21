import 'package:fireship/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Predection extends StatelessWidget {
  final double monthlyEnergyConsumption;
  final double dailySunEnergy;
  final Position position;

  const Predection({Key key, this.monthlyEnergyConsumption, this.position, this.dailySunEnergy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Start',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.star, color: Colors.white),
              onPressed: () async {
                await Provider.of<AuthService>(context).signOut();
                Navigator.pushNamed(context, '/');
              },
            ),
          ]),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Location : " + position.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("monthly Energy Consumption : " +
                        monthlyEnergyConsumption.toString() +
                        " kW-hr"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("daily Sun Energy/m²(dnr+diff) : " +
                        dailySunEnergy.toString() +
                        " kW-hr/m^2/day"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("daily Energy Consumption : " +
                        (monthlyEnergyConsumption / 30).toString() +
                        " kW-hr"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Sattry price in your region : " + (2685.45).toString() + "Cur/capacity"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Solar panel price in your region : " + (7985.45).toString() + "Cur/m²"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Solar panel investement : " + 89562.66.toString() + " cur"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Battries investement : " + 27867.66.toString() + " cur"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("total investement : " + 117429.66.toString() + " cur"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text("cost of electricity in your region : " + 48.66.toString() + " cur"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("cost of electricity in your region for 10 years :" +
                        48.66.toString() +
                        " cur"),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            "How mush money you will save if you switch to clean energy for 10 years period: ",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            31781.66.toString() + " Cur",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
