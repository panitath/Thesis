
import 'package:first_app/model/delegate_model.dart';
import 'package:flutter/material.dart';

class DelegateProvider extends ChangeNotifier {


  int? empcode;
  String? leavetype;
  int? empcodemanager;
  String? managername;
    String? manageremail;
  DateTime? startdate;
  DateTime? enddate;
  int? empcodedelegate;
  String? delegatename;
  DateTime? createdate;



List<DelegateItem>? _delegateList;
  get delegateList => this._delegateList;

  set setdelegateList(value) {
    this._delegateList = value;
    notifyListeners();
  }


get getempcode => this.empcode;

  set setempcode(empcode) {
    this.empcode = empcode;
    notifyListeners();
  }

  get getleaveetype => this.leavetype;

  set setleavetype(leavetype) {
    this.leavetype = leavetype;
    notifyListeners();
  }


  get getempcodemanager => this.empcodemanager;

  set setempcodemanager(empcodemanager) {
    this.empcodemanager = empcodemanager;
    notifyListeners();
  } 

   get getmanagername => this.managername;

  set setemanagername(managername) {
    this.managername = managername;
    notifyListeners();
  } 

  get getmanageremail => this.manageremail;

  set setemanageremail(manageremail) {
    this.manageremail = manageremail;
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

  get getempcodedelegate => this.empcodedelegate;
  set setempcodedelegate(empcodedelegate) {
    this.empcodedelegate = empcodedelegate;
    notifyListeners();
  }
}

class DelegateItem {
  final int empcode;
  final String leavetype;
  final int empcodemanager;
  final String managername;
  final String manageremail;
  final DateTime startdate;
  final DateTime enddate;
  final int empcodedelegate;
  final String delegatename;
  final DateTime createdate;


  const DelegateItem({
    Key? key,
    required this.empcode,
   required this.leavetype,
   required this.empcodemanager,
   required this.managername,
   required this.manageremail,
   required this.startdate,
   required this.enddate,
   required this.empcodedelegate,
   required this.delegatename,
   required this.createdate

  });

  add(Map<String, String> map) {}
}

