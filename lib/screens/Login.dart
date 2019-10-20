import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/shared.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  bool isLoaded;

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, 'home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: Text('Loading'),
    );
  }
  */

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Center(
          child: LoginButton(
            text: 'LOGIN WITH GOOGLE',
            icon: FontAwesomeIcons.google,
            color: Colors.lightBlue,
            loginMethod: auth.googleSignIn,
          ),
        ),
      ),
    );
  }

}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, 'home');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
