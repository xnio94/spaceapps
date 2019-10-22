import 'package:fireship/shared/enumMode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CircleButton.dart';
import 'ProfileWidget.dart';

class Home extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Home',
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
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CircleButton(
                  alignment: Alignment(-.8, -1),
                  text: "Top Profiles",
                  radius: 190,
                  mode: Mode.blue,
                  onTap: () {
                    Navigator.pushNamed(context, 'topProfiles');
                  },
                ),
                CircleButton(
                  alignment: Alignment(-1, .5),
                  text: "Start",
                  radius: 350,
                  mode: Mode.blue,
                  onTap: () {
                    Navigator.pushNamed(context, 'start');
                  },
                ),
                CircleButton(
                  alignment: Alignment(.95, .95),
                  text: 'Invite',
                  radius: 120,
                  mode: Mode.blue,
                  onTap: () {
                    //Navigator.pushNamed(context, 'start');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
