import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/clock.dart';

abstract class ClockServices {
  
  Future<void> addClock(Clock items);
  Future<List<Clock>> getEmpClockList(int _empcode);
  
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

  

   @override
  Future<List<Clock>> getEmpClockList(int empcode) async {
        // DateTime startDate = DateTime.utc(start.year, start.month, start.day );
        //  DateTime toDate = DateTime.utc(to.year, to.month, to.day );
    QuerySnapshot snapshot =await FirebaseFirestore.instance.collection('CLOCK')
     .where('empcode', isEqualTo: empcode).orderBy("createdate")
    //   .where('createdate',  isGreaterThanOrEqualTo:  startDate)
    //  .where('createdate', isLessThanOrEqualTo: toDate)
     .get();
      
    AllClockList empclocks = AllClockList.fromSnapshot(snapshot);
    return empclocks.clocklist;
  }

 
}
 