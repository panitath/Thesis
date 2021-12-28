import 'package:cloud_firestore/cloud_firestore.dart';

class Clock {
  int empcode;
  DateTime clocktime;
  String currentlocation;
  DateTime createdate;

  Clock(
      this.empcode,
      this.clocktime,
      this.currentlocation,
      this.createdate);

  factory Clock.fromDs(
    Map<String, Object?> json,
  ) {
    return Clock(
      json['empcode'] as int,
      json['clocktime'] as DateTime,
      json['currentlocation'] as String,
      json['createdate'] as DateTime,
    );
  }

  factory Clock.fromJson(
    Map<String, dynamic> json,
  ) {
    return Clock(
      json['empcode'] as int,
      json['clocktime'] as DateTime,
      json['currentlocation'] as String,
      json['createdate'] as DateTime,
    );
  }
}

class AllClock {
  final List<Clock> clock;
  AllClock(this.clock);

  factory AllClock.fromSnapshot(QuerySnapshot s) {
    List<Clock> clock = s.docs.map((DocumentSnapshot ds) {
      return Clock.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllClock(clock);
  }
}



class ClockList {
    int empcode;
  DateTime clocktime;
  String currentlocation;
  DateTime createdate;

 ClockList(
     this.empcode,
      this.clocktime,
      this.currentlocation,
      this.createdate);
      
      factory ClockList.fromDs(
    Map<String, Object?> json,
  ) {
    return ClockList(
      json['empcode'] as int,
      json['clocktime'] as DateTime,
      json['currentlocation'] as String,
      json['createdate'] as DateTime,
    );
  }



factory ClockList.fromJson(
    Map<String, dynamic> json,
  ) {
    return ClockList(
     json['empcode'] as int,
      json['clocktime'] as DateTime,
      json['currentlocation'] as String,
      json['createdate'] as DateTime,
    );
  }

}

