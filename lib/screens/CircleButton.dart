import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final String text;
  final double radius;
  final Function onTap;
  final Alignment alignment;
  final Color color;

  const CircleButton({Key key, this.text, this.radius, this.onTap, this.alignment, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:alignment??Alignment(-1,-1),
      child: Material(
        elevation: 35.0,
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: color??Colors.lightBlue,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.black,
          child: Container(
            padding: EdgeInsets.all(radius /20+5),
            width: radius,
            height: radius,
            child: Center(
              child: AutoSizeText(
                text,
                maxLines: 2,
                wrapWords: false,
                style: TextStyle(fontSize: 1000,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
