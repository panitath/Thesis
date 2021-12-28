
import 'package:first_app/model/emp_leave.dart';
import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
   int? empcode;
  String? title;
  String? empfullname;
  String? empemail;
    int? empcodemanager;
  String? managername;
 String? comment;
 String? status;
DateTime? attendancein;
  DateTime? attendanceout;
DateTime? createdate;

List<AttendanceItem>? _attendanceList;
  get attendanceList => this._attendanceList;

  set setattendanceList(value) {
    this._attendanceList = value;
    notifyListeners();
  }

get getempcode => this.empcode;

  set setempcode(empcode) {
    this.empcode = empcode;
    notifyListeners();
  }

  get gettitle => this.title;

  set setleaveid(leavetype) {
    this.title = title;
    notifyListeners();
  }

  get getempfullname => this.empfullname;

  set setempfullname(empfullname) {
    this.empfullname = empfullname;
    notifyListeners();
  }

  get getempemail => this.empemail;

  set setempemail(empemail) {
    this.empemail = empemail;
    notifyListeners();
  }

  get getempcodemanager => this.empcodemanager;

  set setempcodemanager(empcodemanager) {
    this.empcodemanager = empcodemanager;
    notifyListeners();
  }
   get getmanagername => this.managername;

  set setmanagername(managername) {
    this.managername = managername;
    notifyListeners();
  }

   get getcomment => this.comment;

  set setcomment(comment) {
    this.comment = comment;
    notifyListeners();
  }

   get gestatus => this.status;

  set setstatus(status) {
    this.status = status;
    notifyListeners();
  }

   get getattendancein => this.attendancein;

  set setattendancein(attendancein) {
    this.attendancein = attendancein;
    notifyListeners();
  }

  
   get getattendanceout => this.attendanceout;

  set setattendanceout(attendanceout) {
    this.attendanceout = attendanceout;
    notifyListeners();
  }

  
   get getcreatedate => this.createdate;

  set setcreatedate(createdate) {
    this.createdate = createdate;
    notifyListeners();
  }
}

class AttendanceItem {
  final int empcode;
   final String title;
  final String empfullname;
  final String empemail;
   final  int empcodemanager;
  final String managername;
 final String comment;
 final String status;
final DateTime attendancein;
 final  DateTime attendanceout;
final DateTime createdate;

  const AttendanceItem({
    Key? key,
    required this.empcode,
    required this.title,
 required this.empfullname,
 required this.empemail,
    required this.empcodemanager,
  required this.managername,
 required this.comment,
 required this.status,
required this.attendancein,
  required this.attendanceout,
required this.createdate
  });

  add(Map<String, String> map) {}
}
