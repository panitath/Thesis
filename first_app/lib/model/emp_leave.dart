import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Empleave {
  int empcode;
  String leavetype;
  DateTime startdate;
  DateTime enddate;
  String comment;
  String status;
  int empcodemanager;
  String managername;
  DateTime createdate;

  Empleave(
      this.empcode,
      this.leavetype,
      this.startdate,
      this.enddate,
      this.comment,
      this.status,
      this.empcodemanager,
      this.managername,
      this.createdate);

  factory Empleave.fromDs(
    Map<String, Object?> json,
  ) {
    return Empleave(
      json['empcode'] as int,
      json['leavetype'] as String,
      json['startdate'] as DateTime,
      json['enddate'] as DateTime,
      json['comment'] as String,
      json['status'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['createdate'] as DateTime,
    );
  }

  factory Empleave.fromJson(
    Map<String, dynamic> json,
  ) {
    return Empleave(
      json['empcode'] as int,
      json['leavetype'] as String,
      json['startdate']!.toDate() as DateTime,
      json['enddate']!.toDate() as DateTime,
      json['comment'] as String,
      json['status'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['createdate']!.toDate() as DateTime,
    );
  }
}

class AllEmpleaves {
  final List<Empleave> empleaves;
  AllEmpleaves(this.empleaves);

  factory AllEmpleaves.fromSnapshot(QuerySnapshot s) {
    List<Empleave> empleaves = s.docs.map((DocumentSnapshot ds) {
      return Empleave.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllEmpleaves(empleaves);
  }
}

class SinglEmpleaves {
  final Empleave empleave;
  SinglEmpleaves(this.empleave);

  factory SinglEmpleaves.fromJson(QuerySnapshot s) {
    var empleave = s.docs.map((DocumentSnapshot ds) {
      return Empleave.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SinglEmpleaves(empleave.first);
  }
}

// //State
// class EmpleaveModel extends ChangeNotifier {
//  int? _empcode;
//  String? _leavetype;
//  DateTime? _startdate;
//  DateTime? _enddate;
//  String? _comment;
//  DateTime? _createdate;

//   get empcode => this._empcode;

//   set empcode(value) {
//     this.empcode = value;
//     notifyListeners();
//   }

//   get leavetype => this._leavetype;

//   set leavetype(value) {
//     this._leavetype = value;
//     notifyListeners();
//   }

//    get startdate => this._startdate;

//   set startdate(value) {
//     this._startdate = value;
//     notifyListeners();
//   }
// get enddate => this._enddate;

//   set enddate(value) {
//     this._enddate = value;
//     notifyListeners();
//   }

//   get comment => this._comment;

//   set comment(value) {
//     this._comment = value;
//     notifyListeners();
//   }

//    get createdate => this._createdate;

//   set createdate(value) {
//     this._createdate = value;
//     notifyListeners();
//   }

// }

class EmpleaveList {
  int empcode;
  String leavetype;
  DateTime startdate;
  DateTime enddate;
  String comment;
  String status;
  int empcodemanager;
  String managername;

  DateTime createdate;

  EmpleaveList(
      this.empcode,
      this.leavetype,
      this.startdate,
      this.enddate,
      this.comment,
      this.status,
      this.empcodemanager,
      this.managername,
      this.createdate);
  factory EmpleaveList.fromDs(
    Map<String, Object?> json,
  ) {
    return EmpleaveList(
      json['empcode'] as int,
      json['leavetype'] as String,
      json['startdate'] as DateTime,
      json['enddate'] as DateTime,
      json['comment'] as String,
      json['status'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['createdate'] as DateTime,
    );
  }

  factory EmpleaveList.fromJson(
    Map<String, dynamic> json,
  ) {
    return EmpleaveList(
      json['empcode'] as int,
      json['leavetype'] as String,
      json['startdate']!.toDate() as DateTime,
      json['enddate']!.toDate() as DateTime,
      json['comment'] as String,
      json['status'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['createdate']!.toDate() as DateTime,
    );
  }
}

class AllEmpleaveList {
  final List<Empleave> leavelist;
  AllEmpleaveList(this.leavelist);

  factory AllEmpleaveList.fromSnapshot(QuerySnapshot s) {
    print('model');
    List<Empleave> leavelists = s.docs.map((DocumentSnapshot ds) {
      return Empleave.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    print('return');
    return AllEmpleaveList(leavelists);
  }
}
