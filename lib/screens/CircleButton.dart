import 'package:auto_size_text/auto_size_text.dart';
import 'package:greenearth/shared/enumMode.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final String text;
  final double radius;
  final Function onTap;
  final Alignment alignment;
  final Mode mode;
  final Widget loading;

  const CircleButton({Key key, this.text, this.radius, this.onTap, this.alignment, this.mode, this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment(-1, -1),
      child: Material(
        elevation: 35.0,
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: (mode == Mode.green)
            ? Colors.green
            : (mode == Mode.blue) ? Colors.lightBlue : Colors.grey,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.black,
          child: Container(
            padding: EdgeInsets.all(radius / 20 + 5),
            width: radius,
            height: radius,
            child: loading??Center(
              child: AutoSizeText(
                text,
                maxLines: 2,
                wrapWords: false,
                style: TextStyle(fontSize: 1000, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          onTap: (mode==Mode.grey)?(){}:onTap,
        ),
      ),
    );
  }
}
