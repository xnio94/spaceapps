import 'services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


/// Static global state. Immutable services that do not care about build context. 
class Global {
  // App Data
  static final String title = 'Fireship';
  static final DateTime firstDate =  DateTime(2019,9,1);//DateTime(2019,10,1);
  static List<String> days = ['الأحد','الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', ];


  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

    // Data Models
  static final Map models = {
    aDay:    (data,documentID) => aDay.fromMap(data,documentID),
  };

  static final Collection<aDay> topicsRef = Collection<aDay>(path: 'mama_days');

  
}
