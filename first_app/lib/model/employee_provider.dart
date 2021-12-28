
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  int? empcode;
  String? title;
  String? fullname;
  String? email;


// List<EmpleaveItem>? _empleaveList;
//   get empleaveList => this._empleaveList;

//   set setempleaveList(value) {
//     this._empleaveList = value;
//     notifyListeners();
//   }

get getempcode => this.empcode;

  set setempcode(empcode) {
    this.empcode = empcode;
    notifyListeners();
  }

  get gettitle => this.title;

  set settitle(title) {
    this.title = title;
    notifyListeners();
  }

  get getfullname => this.fullname;

  set setfullname(fullname) {
    this.fullname = fullname;
    notifyListeners();
  }

  get getemail => this.email;

  set setemail(email) {
    this.email = email;
    notifyListeners();
  }

}

// class EmpleaveItem {
//   final int empcode;
//   final String leavetype;
//   final DateTime startdate;
//   final DateTime enddate;
//   final String comment;
//    final String status;
//     final   int empcodemanager;
//  final  String managername;
//   final DateTime createdate;

//   const EmpleaveItem({
//     Key? key,
//     required this.empcode,
//     required this.leavetype,
//     required this.startdate,
//     required this.enddate,
//     required this.comment,
//     required this.status,
//      required this.empcodemanager,
//     required this.managername,
//     required this.createdate,
//   });

//   add(Map<String, String> map) {}
// }
