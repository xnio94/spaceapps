import 'package:fireship/services/db.dart';
import 'package:fireship/services/globals.dart';
import 'package:fireship/services/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInfoScreen extends StatelessWidget {
  final aDay myDay;

  const ProfileInfoScreen({Key key, this.myDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dat = Global.firstDate.add(Duration(days: myDay.documentID));
    String datS =
        dat.day.toString() + '/' + dat.month.toString() + '/' + (dat.year % 100).toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(datS),
      ),
      body: Column(
        children: <Widget>[
          Hero(
            tag: myDay.documentID,
            child: Material(
              color:Theme.of(context).backgroundColor,// Colors.blueGrey.shade400,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Center(
                        child: Text('', style: TextStyle(fontSize: 60)),
                      ),
                      Center(
                        child: Text('', style: TextStyle(fontSize: 50)),
                      ),
                      Center(
                        child:
                            Text(Global.days[myDay.documentID % 7], style: TextStyle(fontSize: 40)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.all(10),
              /*color: Color.fromARGB(255, (myDay.documentID % 7) * 10,
                  (myDay.documentID % 7) * 13 + 15, (myDay.documentID % 7) * 20 + 80),
              */
              child: Provider<aDay>.value(
                value: myDay, //documentID
                child: DayData(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DayData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        MyButton(
          text1: 'الروسيطة',
          text2: Provider.of<aDay>(context).profit.toString(),
        ),
        MyButton(text1: 'المصاريف', text2: Provider.of<aDay>(context).losses.toString()),
        Flexible(
          child: MyButton(
            isDesc: true,
            text1: ':التفاصيل',
            text2: Provider.of<aDay>(context).description.toString(),
          ),
        ),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  final String text1, text2;
  final bool isDesc;

  const MyButton({Key key, this.text1, this.text2, this.isDesc = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: RaisedButton(

        color: Theme.of(context).primaryColor,
        onPressed: () async {
          aDay day = Provider.of<aDay>(context);
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialog(
                day: day, //Provider.of<int>(context),
                isDesc: isDesc,
                text1: text1,
                text2: text2,
              );
            },
          );
        },
        child: (isDesc)
            ? DescContent(text1: text1, text2: text2)
            : ButtonContent(text2: text2, text1: text1),
      ),
    );
  }
}

class DescContent extends StatelessWidget {
  const DescContent({
    Key key,
    @required this.text2,
    @required this.text1,
  }) : super(key: key);
  final String text2;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: Text(
            text1,
            style: TextStyle(fontSize: 25),
          ),
        ),
        Flexible(
          child: Text(
            text2,
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}

class ButtonContent extends StatelessWidget {
  const ButtonContent({
    Key key,
    @required this.text2,
    @required this.text1,
  }) : super(key: key);
  final String text2;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            text2,
            style: TextStyle(fontSize: 25),
          ),
        ),
        Flexible(
          child: Text(
            text1,
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}

class MyDialog extends StatefulWidget {
  final String text1, text2;

  final bool isDesc;

  final aDay day;

  const MyDialog({Key key, this.text1, this.text2, this.isDesc, this.day}) : super(key: key);

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
        textDirection: TextDirection.rtl,
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textDirection: TextDirection.ltr,
          keyboardType: widget.isDesc ? TextInputType.multiline : TextInputType.number,
          maxLines: null,
          controller: controller,
          focusNode: focusNode,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.done,
          ),
          onPressed: () {
            switch (widget.text1) {
              case 'الروسيطة':
                submitToFirebase(int.tryParse(controller.text) ?? 0, 'profit');
                widget.day.profit = int.tryParse(controller.text) ?? 0;
                break;
              case 'المصاريف':
                submitToFirebase(int.tryParse(controller.text) ?? 0, 'losses');
                widget.day.losses = int.tryParse(controller.text) ?? 0;
                break;
              case ':التفاصيل':
                submitToFirebase(controller.text, 'description');
                widget.day.description = controller.text;
                break;
            }
            Navigator.pop(context, 1);
          },
        )
      ],
    );
  }

  void submitToFirebase(value, String field) {
    Provider.of<MyDb>(context).setDataToDoc(
      widget.day.documentID,
      {field: value},
    );
  }
}
