import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/clock.dart';

abstract class ClockServices {
  
  Future<void> addClock(Clock items);
}

class ClockService extends ClockServices {
   CollectionReference _ref = FirebaseFirestore.instance.collection('CLOCK');

  @override
  Future<void> addClock(Clock items) {
    return _ref.add({
      
      'empcode': items.empcode,
      'clocktime': items.clocktime,
      'currentlocation': items.currentlocation,
      'createdate':DateTime.now()
    });

  }
 
}
 