import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ProfileWidget.dart';

class TopProfiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Top Profiles',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Container(color:Theme.of(context).backgroundColor,),
    );
  }
}

class TopProfiles2 extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Top Profiles',
            style: TextStyle(fontSize: 30),
          ),
          actions: [
            IconButton(
              icon: Icon(FontAwesomeIcons.arrowUp, color: Colors.white),
              onPressed: () {
                _controller.animateTo(
                  _controller.position.minScrollExtent,
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.ease,
                );
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.calendarCheck, color: Colors.white),
              onPressed: () async {
                await Provider.of<AuthService>(context).signOut();
                Navigator.pushNamed(context, '/');
              },
            ),
            /*
        IconButton(
          icon: Icon(FontAwesomeIcons.userCircle, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
        */
          ]),
      body: ProfilesView(
        controller: _controller,
      ),
    );
  }
}

class ProfilesView extends StatelessWidget {
  final ScrollController controller;

  const ProfilesView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfItems = DateTime.now().difference(Global.firstDate).inDays;
    List<aDay> myFireDays = Provider.of<List<aDay>>(context);
    List<aDay> myDays = [];
    for (int i = 0; i < numberOfItems + 1; i++) {
      myDays.add(aDay(documentID: i, description: '', profit: 0, losses: 0));
    }
    for (int i = 0; i < myFireDays.length; i++) {
      myDays[myFireDays[i].documentID] = myFireDays[i];
    }
    return ListView.builder(
      itemCount: numberOfItems + 1,
      controller: controller,
      itemBuilder: (context, index) => Container(
        child: Profile(
          myDay: myDays[numberOfItems - index],
        ),
      ),
    );
  }
}
