import 'package:cloud_firestore/cloud_firestore.dart';

class aDay {
   int profit;
   int losses;
   String description;
  final int documentID;
  aDay({this.documentID, this.description, this.profit, this.losses});
  factory aDay.fromMap(Map data,documentID){
    return aDay(
      profit: data['profit']??0,
      losses: data['losses']??0,
      description: data['description']??'',
      documentID:int.parse(documentID),
    );
  }
}