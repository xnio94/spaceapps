import 'package:greenearth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Prediction extends StatelessWidget {
  final double monthlyEnergyConsumption; //kW-hr
  final double dailyEnergyConsumption; //kW-hr
  final double dailySunEnergy;
  static const double regionalBatteryPrice = 171.40; // $/kW-hr
  static const double regionalSolarPanelPrice = 2040; // $/Kw
  static const double regionalElectricityPrice = 0.12; // $/kW-hr
  final double solarPanelInvestment;
  final double batteriesInvestment;
  final double regionalElectricityPriceFor15Years;
  final Position position;

  const Prediction({
    Key key,
    this.monthlyEnergyConsumption,
    this.position,
    this.dailySunEnergy,
  })  : dailyEnergyConsumption = (monthlyEnergyConsumption / 30),
        solarPanelInvestment = 2 * regionalSolarPanelPrice * (monthlyEnergyConsumption / 30) / 12,
        batteriesInvestment = 1.2 * regionalBatteryPrice * (monthlyEnergyConsumption / 30),
        regionalElectricityPriceFor15Years =
            (regionalElectricityPrice * 5475 * monthlyEnergyConsumption / 30),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Start',
        ),
      ),
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
                        dailyEnergyConsumption.toString() +
                        " kW-hr"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Battery  price in your region : " +
                        regionalBatteryPrice.toString() +
                        " \$/kW-hr"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Solar panel price in your region : " +
                        regionalSolarPanelPrice.toString() +
                        " \$/Kw "),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Solar panel investement : " + solarPanelInvestment.toString() + " \$"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text("Batteries investement : " + batteriesInvestment.toString() + " \$"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("total investement : " +
                        (batteriesInvestment + solarPanelInvestment).toString() +
                        " \$"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("cost of electricity in your region : " +
                        regionalElectricityPrice.toString() +
                        " \$/Kw-hr"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("cost of electricity in your region for 15 years :" +
                        regionalElectricityPriceFor15Years.toString() +
                        " \$"),
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
                            "How mush money you will save if you switch to clean energy for 15 years period: ",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            (regionalElectricityPriceFor15Years -
                                        batteriesInvestment -
                                        solarPanelInvestment).floor()
                                    .toString() +
                                " \$",
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
