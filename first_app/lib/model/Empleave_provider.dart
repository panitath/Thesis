
import 'package:first_app/model/emp_leave.dart';
import 'package:flutter/material.dart';

class EmpleaveProvider extends ChangeNotifier {
  int? empcode;
  String? leavetype;
  DateTime? startdate;
  DateTime? enddate;
  String? comment;
  String? status;
    int? empcodemanager;
  String? managername;
  DateTime? createdate;

List<EmpleaveItem>? _empleaveList;
  get empleaveList => this._empleaveList;

  set setempleaveList(value) {
    this._empleaveList = value;
    notifyListeners();
  }

get getempcode => this.empcode;

  set setempcode(empcode) {
    this.empcode = empcode;
    notifyListeners();
  }

  get getleavetype => this.leavetype;

  set setleaveid(leavetype) {
    this.leavetype = leavetype;
    notifyListeners();
  }

  get getstartdate => this.startdate;

  set setstartdate(startdate) {
    this.startdate = startdate;
    notifyListeners();
  }

  get getenddate => this.enddate;

  set setenddate(enddate) {
    this.enddate = enddate;
    notifyListeners();
  }

  get getcomment => this.comment;

  set setcomment(comment) {
    this.comment = comment;
    notifyListeners();
  }
   get getstatus => this.status;

  set setstatus(status) {
    this.status = status;
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
}

class EmpleaveItem {
  final int empcode;
  final String leavetype;
  final DateTime startdate;
  final DateTime enddate;
  final String comment;
   final String status;
    final   int empcodemanager;
 final  String managername;
  final DateTime createdate;

  const EmpleaveItem({
    Key? key,
    required this.empcode,
    required this.leavetype,
    required this.startdate,
    required this.enddate,
    required this.comment,
    required this.status,
     required this.empcodemanager,
    required this.managername,
    required this.createdate,
  });

  add(Map<String, String> map) {}
}
