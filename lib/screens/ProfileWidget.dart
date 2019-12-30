import 'package:greenearth/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import 'ProfileInfoScreen.dart';

class Profile extends StatelessWidget {
  final aDay myDay;

  const Profile({Key key, this.myDay}):super(key: key);
  @override
  Widget build(BuildContext context) {
    int index =myDay.documentID;
    DateTime dat = Global.firstDate.add(Duration(days: index));
    String datS =
        dat.day.toString() + '/' + dat.month.toString() + '/' + (dat.year % 100).toString();
    return Hero(
      tag: index,
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ProfileInfoScreen(myDay: myDay),
              ),
            );
          },
          child: Container(
            decoration: (DateTime.now().difference(Global.firstDate).inDays==index)
                ? BoxDecoration(
                    border: Border.all(width: 5, color: Colors.white),
                  )
                : BoxDecoration(),
            padding: EdgeInsets.all(15),
            child: Stack(
              alignment: AlignmentDirectional.center,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment:Alignment(-1, 0),
                    child:Text(myDay.profit.toString(), style: TextStyle(fontSize: 25)),
                ),
                Align(
                  alignment: Alignment(-0.1, 0),
                  child: Text(datS, style: TextStyle(fontSize: 17)),
                ),
                Align(
                  alignment: Alignment(1, 0),
                  child: Text(Global.days[index % 7], style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
