import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Attendance {
  int empcode;
  String title;
  String empfullname;
  String empemail;
    int empcodemanager;
  String managername;
 String comment;
 String status;
DateTime attendancein;
  DateTime attendanceout;
DateTime createdate;
 

  Attendance(
      this.empcode,
     this.title,
  this.empfullname,
this.empemail,
this.empcodemanager,
this.managername,
this.comment,
this.status,
this. attendancein,
  this.attendanceout,
this.createdate
      
      );

  factory Attendance.fromDs(
    Map<String, Object?> json,
  ) {
    return Attendance(
      json['empcode'] as int,
      json['title'] as String,
      json['empfullname'] as String,
      json['empemail'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['comment'] as String,
      json['status'] as String,
      json['attendancein'] as DateTime,
      json['attendanceout'] as DateTime,
      json['createdate'] as DateTime,
  
    
    );
  }

  factory Attendance.fromJson(
    Map<String, dynamic> json,
  ) {
    return Attendance(
      json['empcode'] as int,
      json['title'] as String,
      json['empfullname'] as String,
      json['empemail'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['comment'] as String,
      json['status'] as String,
      json['attendancein']!.toDate() as DateTime,
      json['attendanceout']!.toDate() as DateTime,
      json['createdate']!.toDate() as DateTime,
    );
  }
}

class AllAttendance {
  final List<Attendance> attendance;
  AllAttendance(this.attendance);

  factory AllAttendance.fromSnapshot(QuerySnapshot s) {
    List<Attendance> attendance = s.docs.map((DocumentSnapshot ds) {
      return Attendance.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllAttendance(attendance);
  }
}

class SingleAttendance{
  final Attendance attendance;
  SingleAttendance(this.attendance);

  factory SingleAttendance.fromJson(QuerySnapshot s) {
    var attendance = s.docs.map((DocumentSnapshot ds) {
      return Attendance.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SingleAttendance(attendance.first);
  }
}

class AttendanceList {
  int empcode;
  String title;
  String empfullname;
  String empemail;
    int empcodemanager;
  String managername;
 String comment;
 String status;
DateTime attendancein;
  DateTime attendanceout;
DateTime createdate;

  AttendanceList(
        this.empcode,
     this.title,
  this.empfullname,
this.empemail,
this.empcodemanager,
this.managername,
this.comment,
this.status,
this. attendancein,
  this.attendanceout,
this.createdate);
  factory AttendanceList.fromDs(
    Map<String, Object?> json,
  ) {
    return AttendanceList(
  json['empcode'] as int,
      json['title'] as String,
      json['empfullname'] as String,
      json['empemail'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['comment'] as String,
      json['status'] as String,
      json['attendancein'] as DateTime,
      json['attendanceout'] as DateTime,
      json['createdate'] as DateTime,
    );
  }

  factory AttendanceList.fromJson(
    Map<String, dynamic> json,
  ) {
    return AttendanceList(
       json['empcode'] as int,
      json['title'] as String,
      json['empfullname'] as String,
      json['empemail'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['comment'] as String,
      json['status'] as String,
      json['attendancein']!.toDate() as DateTime,
      json['attendanceout']!.toDate() as DateTime,
      json['createdate']!.toDate() as DateTime,
    );
  }
}

class AllAttendanceList {
  final List<Attendance> attendancelist;
  AllAttendanceList(this.attendancelist);

  factory AllAttendanceList.fromSnapshot(QuerySnapshot s) {
    print('model');
    List<Attendance> attendancelist = s.docs.map((DocumentSnapshot ds) {
      return Attendance.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    print('return');
    return AllAttendanceList(attendancelist);
  }
}
